FROM monogramm/docker-taiga-back-base:4.2-alpine

LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>"

# Taiga additional properties
ENV TAIGA_ENABLE_SLACK=False \
    TAIGA_ENABLE_GITLAB_AUTH=False \
    TAIGA_GITLAB_AUTH_URL=https://gitlab.com \
    TAIGA_GITLAB_AUTH_CLIENT_ID= \
    TAIGA_GITLAB_AUTH_CLIENT_SECRET= \
    TAIGA_ENABLE_GITHUB_AUTH=False \
    TAIGA_GITHUB_AUTH_CLIENT_ID= \
    TAIGA_GITHUB_AUTH_CLIENT_SECRET= \
    TAIGA_ENABLE_LDAP=False \
    TAIGA_LDAP_USE_TLS=True \
    TAIGA_LDAP_SERVER= \
    TAIGA_LDAP_PORT=389 \
    TAIGA_LDAP_BIND_DN= \
    TAIGA_LDAP_BIND_PASSWORD= \
    TAIGA_LDAP_BASE_DN= \
    TAIGA_LDAP_USERNAME_ATTRIBUTE=uid \
    TAIGA_LDAP_EMAIL_ATTRIBUTE=mail \
    TAIGA_LDAP_FULL_NAME_ATTRIBUTE=cn \
    TAIGA_LDAP_SAVE_LOGIN_PASSWORD=True \
    TAIGA_LDAP_FALLBACK=normal \
    TAIGA_ENABLE_OPENID_AUTH=False \
    TAIGA_OPENID_AUTH_USER_URL= \
    TAIGA_OPENID_AUTH_TOKEN_URL= \
    TAIGA_OPENID_AUTH_CLIENT_ID= \
    TAIGA_OPENID_AUTH_CLIENT_SECRET=

# Erase original entrypoint and conf with custom one
COPY custom_db_init.sh /
COPY local.py /taiga/

# Fix custom_db_init permissions
# Install Slack/Mattermost extension
# Install GitLab Auth extension
# Install LDAP extension
# Install OPENID Auth extension
RUN set -ex; \
    chmod 755 /custom_db_init.sh; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-slack; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-gitlab-auth-official; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-github-auth; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-ldap-auth-ext; \
    curl -L -o /tmp/taiga-contrib-openid-auth.zip "https://github.com/robrotheram/taiga-contrib-openid-auth/archive/master.zip"; \
    mkdir -p /tmp/taiga-contrib-openid-auth; \
    unzip /tmp/taiga-contrib-openid-auth.zip -d /tmp/; \
    LC_ALL=C pip install --no-cache-dir /tmp/taiga-contrib-openid-auth-master/back; \
    rm -rf /tmp/taiga-contrib-openid-auth

# Arguments to label built container
ARG VCS_REF=unknown
ARG BUILD_DATE=unknown
ARG VERSION=4.2

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
      product="Taiga Back" \
      version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Monogramm/docker-taiga/" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Taiga Back" \
      org.label-schema.description="Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable." \
      org.label-schema.url="https://www.taiga.io/" \
      org.label-schema.vendor="Taiga" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/Monogramm/docker-taiga/" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="Taiga Back" \
      org.opencontainers.image.description="Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable." \
      org.opencontainers.image.url="https://www.taiga.io/" \
      org.opencontainers.image.vendor="Taiga" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.authors="Monogramm Maintainers <opensource at monogramm dot io>"
