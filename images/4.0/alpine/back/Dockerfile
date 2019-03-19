FROM monogramm/docker-taiga-back-base:4.0-alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

# Taiga additional properties
ENV TAIGA_ENABLE_SLACK=False \
    TAIGA_ENABLE_GITLAB=False \
    TAIGA_GITLAB_URL=https://gitlab.com \
    TAIGA_GITLAB_CLIENT_ID='' \
    TAIGA_GITLAB_CLIENT_SECRET='' \
    TAIGA_ENABLE_GITHUB=False \
    TAIGA_GITHUB_CLIENT_ID='' \
    TAIGA_GITHUB_CLIENT_SECRET='' \
    TAIGA_ENABLE_LDAP=False \
    TAIGA_LDAP_USE_TLS=False \
    TAIGA_LDAP_SERVER='' \
    TAIGA_LDAP_PORT=389 \
    TAIGA_LDAP_BIND_DN='' \
    TAIGA_LDAP_BIND_PASSWORD='' \
    TAIGA_LDAP_BASE_DN='' \
    TAIGA_LDAP_USERNAME_ATTRIBUTE=uid \
    TAIGA_LDAP_EMAIL_ATTRIBUTE=mail \
    TAIGA_LDAP_FULL_NAME_ATTRIBUTE=cn \
    TAIGA_LDAP_FALLBACK=normal

# Erase original entrypoint and conf with custom one
COPY entrypoint.sh /
COPY local.py /taiga/local.py

## Install Slack/Mattermost extension
## Install GitLab Auth extension
## Install LDAP extension
RUN set -ex; \
    chmod 755 /entrypoint.sh; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-slack; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-gitlab-auth-official; \
    LC_ALL=C pip install --no-cache-dir taiga-contrib-ldap-auth-ext
