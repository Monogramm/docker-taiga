#!/bin/bash
set -eo pipefail

images=(
	front
	back
)

variants=(
	alpine
)

min_version='3.4'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-taiga-front-base"
latests=( $( curl -fsSL 'https://api.github.com/repos/taigaio/taiga-front-dist/tags' |tac|tac| \
	grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | \
	sort -urV ) )

# Remove existing images
echo "reset docker images"
find ./images -maxdepth 1 -type d -regextype sed -regex '\./images/[[:digit:]]\+\.[[:digit:]]\+' -exec rm -r '{}' \;

echo "update docker images"
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

                template="Dockerfile-$image.template"
                cp "template/$image/$template" "$tgt/Dockerfile"

                # Replace the variables.
                sed -ri -e '
                    s/%%VARIANT%%/'"$variant"'/g;
                    s/%%VERSION%%/'"$version"'/g;
                ' "$tgt/Dockerfile"

                # Copy the scripts (if any)
                cp $src/*.sh "$tgt/"
                chmod 755 $tgt/*.sh

                # Copy the configuration (if any)
                cp $src/*.py $src/*.json "$tgt/" 2>/dev/null || :

                if [[ $1 == 'build' ]]; then
                    tag="$version-$variant"
                    echo "Build Dockerfile for ${tag}"
                    docker build -t ${dockerRepo}:${tag} "$tgt"
                fi
            done

            cp "template/docker-compose.yml" "$dir/docker-compose.yml"
            cp "template/.env" "$dir/.env"

            # Replace the variables.
            sed -ri -e '
                s/%%VARIANT%%/'"$variant"'/g;
                s/%%VERSION%%/'"$version"'/g;
            ' "$dir/docker-compose.yml"

            travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

        done

	fi

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
