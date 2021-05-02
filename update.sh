#!/bin/bash
set -eo pipefail

declare -A dockerRepo=(
    [front]='monogramm/docker-taiga-front'
    [back]='monogramm/docker-taiga-back'
)

images=(
    front
    back
)

declare -A dockerVariant=(
    [buster]='debian'
    [buster-slim]='debian-slim'
    [alpine]='alpine'
)

variants=(
    alpine
)

min_version='4.2'
dockerLatest='6.0'
dockerDefaultVariant='alpine'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
    [[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

latests=( $( curl -fsSL 'https://api.github.com/repos/taigaio/taiga-front-dist/tags' |tac|tac| \
    grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | \
    sort -urV )
    4.2.14 )

# Remove existing images
echo "reset docker images"
rm -rf ./images/
mkdir ./images/

echo "update docker images"
readmeTags=
githubEnv=
travisEnv=
for latest in "${latests[@]}"; do
    version=$(echo "$latest" | cut -d. -f1-2)

    # Only add versions >= "$min_version"
    if version_greater_or_equal "$version" "$min_version"; then

        for variant in "${variants[@]}"; do
            # Create the version+variant directory with a Dockerfile.
            dir="images/$version/$variant"
            if [ -d "$dir" ]; then
                continue
            fi

            for image in "${images[@]}"; do
                echo "generating $image:$version-$variant"
                src="template/$image"
                tgt="$dir/$image"
                mkdir -p "$tgt"

                template="Dockerfile.$image.template"
                cp "$src/$template" "$tgt/Dockerfile"
                cp "$src/docker-compose.test.yml" "$tgt/docker-compose.test.yml"
                cp "$src/.env" "$tgt/.env"

                # Copy the scripts (if any)
                cp "$src"/*.sh "$tgt/"
                chmod 755 "$tgt"/*.sh

                # Copy the configuration (if any)
                cp "$src"/*.py "$src"/*.json "$tgt/" 2>/dev/null || :

                # DockerHub hooks
                cp -r "$src/hooks" "$tgt/"
                cp -r "$src/test" "$tgt/"

                # Replace the variables.
                sed -ri -e '
                    s/%%VARIANT%%/'"$variant"'/g;
                    s/%%VERSION%%/'"$version"'/g;
                ' "$tgt/Dockerfile" "$tgt/docker-compose.test.yml"

                # DockerHub hooks
                sed -ri -e '
                    s|DOCKER_TAG=.*|DOCKER_TAG='"$version"'|g;
                    s|DOCKER_REPO=.*|DOCKER_REPO='"${dockerRepo[$image]}"'|g;
                ' "$tgt/hooks/run"

                # Create a list of "alias" tags for DockerHub post_push
                tagVariant=${dockerVariant[$variant]}
                if [ "$version" = "$dockerLatest" ]; then
                    if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
                        export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $tagVariant $latest $version latest "
                    else
                        export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $tagVariant "
                    fi
                elif [ "$version" = "$latest" ]; then
                    if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
                        export DOCKER_TAGS="$latest-$tagVariant $latest "
                    else
                        export DOCKER_TAGS="$latest-$tagVariant "
                    fi
                else
                    if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
                        export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $latest $version "
                    else
                        export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant "
                    fi
                fi
                echo "${DOCKER_TAGS} " > "$tgt/.dockertags"

                # Add README tags
                readmeTags="$readmeTags\n-   ${DOCKER_TAGS} (\`$tgt/Dockerfile\`)"

                if [[ $1 == 'build' ]]; then
                    tag="$version-$variant"
                    echo "Build Dockerfile for ${tag}"
                    docker build -t "${dockerRepo[$image]}:${tag}" "$tgt"
                fi
            done

            cp "template/docker-compose.yml" "$dir/docker-compose.yml"
            cp "template/.env" "$dir/.env"

            # Replace the variables.
            sed -ri -e '
                s/%%VARIANT%%/'"$variant"'/g;
                s/%%VERSION%%/'"$version"'/g;
            ' "$dir/docker-compose.yml"

            # Add GitHub Actions env var
            githubEnv="'$version', $githubEnv"

            # Add Travis-CI env var
            travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

        done

    fi

done

# update README.md
sed '/^<!-- >Docker Tags -->/,/^<!-- <Docker Tags -->/{/^<!-- >Docker Tags -->/!{/^<!-- <Docker Tags -->/!d}}' README.md > README.md.tmp
sed -e "s|<!-- >Docker Tags -->|<!-- >Docker Tags -->\n$readmeTags\n|g" README.md.tmp > README.md
rm README.md.tmp

# update .github workflows
sed -i -e "s|version: \[.*\]|version: [${githubEnv}]|g" .github/workflows/hooks.yml

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
