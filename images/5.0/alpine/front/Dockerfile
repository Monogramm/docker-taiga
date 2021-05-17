FROM monogramm/docker-taiga-front-base:5.0-alpine

LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>"

# Taiga additional properties
ENV ENABLE_GITLAB_AUTH=False \
    GITLAB_API_CLIENT_ID= \
    GITLAB_URL=https://gitlab.com \
    ENABLE_GITHUB_AUTH=False \
    GITHUB_AUTH_CLIENT_ID= \
    ENABLE_OPENID=False \
    OPENID_URL= \
    OPENID_NAME= \
    OPENID_CLIENT_ID=

# Add custom init script to original entrypoint and custom conf
COPY custom_init.sh /
COPY conf.json /taiga/

# Set custom_init permissions
# Replace original configuration file
# Setup symbolic links for configuration files
# Install Slack/Mattermost extension
# Install GitLab Auth extension
# Install GitHub Auth extension
# Install Cookie Warning extension
RUN set -ex; \
    chmod 755 /custom_init.sh; \
    SLACK_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-slack/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-slack version: '$SLACK_VERSION'"; \
    mkdir -p /usr/src/taiga-front-dist/dist/plugins/slack/; \
    curl "https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.js" \
        -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.js; \
    curl "https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.json" \
        -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.json; \
    GITLAB_AUTH_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-gitlab-auth-official/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-gitlab-auth-official version: '$GITLAB_AUTH_VERSION'"; \
    curl -L "https://github.com/taigaio/taiga-contrib-gitlab-auth/archive/$GITLAB_AUTH_VERSION.tar.gz" \
        | tar zx -C /tmp; \
    rm -f "/tmp/$GITLAB_AUTH_VERSION.tar.gz"; \
    mv "/tmp/taiga-contrib-gitlab-auth-$GITLAB_AUTH_VERSION/front/dist" \
        /usr/src/taiga-front-dist/dist/plugins/gitlab-auth; \
    rm -rf "/tmp/taiga-contrib-gitlab-auth-$GITLAB_AUTH_VERSION"; \
    GITHUB_AUTH_VERSION=$(curl -s https://pypi.org/pypi/taiga-contrib-github-auth/json \
        | grep -oE '"version":"[[:digit:]]+(\.[[:digit:]]+)?(\.[[:digit:]]+)?"' \
        | cut -d\" -f4); \
    echo "taiga-contrib-github-auth version: '$GITHUB_AUTH_VERSION'"; \
    curl -L "https://github.com/taigaio/taiga-contrib-github-auth/archive/$GITHUB_AUTH_VERSION.tar.gz" \
        | tar zx -C /tmp; \
    rm -f "/tmp/$GITHUB_AUTH_VERSION.tar.gz"; \
    mv "/tmp/taiga-contrib-github-auth-$GITHUB_AUTH_VERSION/front/dist" \
        /usr/src/taiga-front-dist/dist/plugins/github-auth; \
    rm -rf "/tmp/taiga-contrib-github-auth-$GITHUB_AUTH_VERSION"; \
    COOKIE_WARNING_VERSION=stable; \
    echo "taiga-contrib-cookie-warning version: '$COOKIE_WARNING_VERSION'"; \
    curl -L "https://github.com/taigaio/taiga-contrib-cookie-warning/archive/$COOKIE_WARNING_VERSION.tar.gz" \
        | tar zx -C /tmp; \
    rm -f "/tmp/$COOKIE_WARNING_VERSION.tar.gz"; \
    mv "/tmp/taiga-contrib-cookie-warning-$COOKIE_WARNING_VERSION/dist" \
        /usr/src/taiga-front-dist/dist/plugins/cookie-warning; \
    rm -rf "/tmp/taiga-contrib-cookie-warning-$COOKIE_WARNING_VERSION"

# Arguments to label built container
ARG VCS_REF=unknown
ARG BUILD_DATE=unknown
ARG VERSION=5.0

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
      product="Taiga Front" \
      version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Monogramm/docker-taiga/" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Taiga Front" \
      org.label-schema.description="Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable." \
      org.label-schema.url="https://www.taiga.io/" \
      org.label-schema.vendor="Taiga" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/Monogramm/docker-taiga/" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="Taiga Front" \
      org.opencontainers.image.description="Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable." \
      org.opencontainers.image.url="https://www.taiga.io/" \
      org.opencontainers.image.vendor="Taiga" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.authors="Monogramm Maintainers <opensource at monogramm dot io>"
