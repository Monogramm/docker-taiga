FROM monogramm/docker-taiga-front-base:4.1-alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

# Taiga additional properties
ENV TAIGA_GITLAB_CLIENT_ID='' \
    TAIGA_GITLAB_URL=https://gitlab.com \
    TAIGA_GITHUB_CLIENT_ID=''

# Erase original entrypoint and conf with custom one
COPY entrypoint.sh /
COPY conf.json /taiga/conf.json

# Fix entrypoint permissions
# Setup symbolic links for configuration files
# Install Slack/Mattermost extension
# Install GitLab Auth extension
# Install GitHub Auth extension
# Install Cookie Warning extension
RUN set -ex; \
    chmod 755 /entrypoint.sh; \
    ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/conf.json; \
    mkdir -p /usr/src/taiga-front-dist/dist/js/; \
    ln -s /taiga/conf.json /usr/src/taiga-front-dist/dist/js/conf.json; \
    SLACK_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-slack/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-slack version: \"$SLACK_VERSION\""; \
    mkdir -p /usr/src/taiga-front-dist/dist/plugins/slack/; \
    curl https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.js \
        -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.js; \
    curl https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.json \
        -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.json; \
    GITLAB_AUTH_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-gitlab-auth-official/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-gitlab-auth-official version: \"$GITLAB_AUTH_VERSION\""; \
    curl -L https://github.com/taigaio/taiga-contrib-gitlab-auth/archive/$GITLAB_AUTH_VERSION.tar.gz \
        | tar zx -C /tmp; \
    rm -f /tmp/$GITLAB_AUTH_VERSION.tar.gz; \
    mv /tmp/taiga-contrib-gitlab-auth-$GITLAB_AUTH_VERSION/front/dist \
        /usr/src/taiga-front-dist/dist/plugins/gitlab-auth; \
    rm -rf /tmp/taiga-contrib-gitlab-auth-$GITLAB_AUTH_VERSION; \
    GITHUB_AUTH_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-github-auth/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-github-auth version: \"$GITHUB_AUTH_VERSION\""; \
    curl -L https://github.com/taigaio/taiga-contrib-github-auth/archive/$GITHUB_AUTH_VERSION.tar.gz \
        | tar zx -C /tmp; \
    rm -f /tmp/$GITHUB_AUTH_VERSION.tar.gz; \
    mv /tmp/taiga-contrib-github-auth-$GITHUB_AUTH_VERSION/front/dist \
        /usr/src/taiga-front-dist/dist/plugins/github-auth; \
    rm -rf /tmp/taiga-contrib-github-auth-$GITHUB_AUTH_VERSION; \
    COOKIE_WARNING_VERSION=stable; \
    echo "taiga-contrib-cookie-warning version: \"$COOKIE_WARNING_VERSION\""; \
    curl -L https://github.com/taigaio/taiga-contrib-cookie-warning/archive/$COOKIE_WARNING_VERSION.tar.gz \
        | tar zx -C /tmp; \
    rm -f /tmp/$COOKIE_WARNING_VERSION.tar.gz; \
    mv /tmp/taiga-contrib-cookie-warning-$COOKIE_WARNING_VERSION/dist \
        /usr/src/taiga-front-dist/dist/plugins/cookie-warning; \
    rm -rf /tmp/taiga-contrib-cookie-warning-$COOKIE_WARNING_VERSION
