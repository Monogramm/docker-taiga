#!/bin/sh
set -e

#log() {
#  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $@"
#}


#########################################
## GITLAB
#########################################

if [ "$TAIGA_ENABLE_GITLAB_AUTH" = "True" ]; then
  if ! echo "${TAIGA_CONTRIB_PLUGINS}" | grep 'gitlab-auth'; then
    log "Adding Taiga Front GitLab Auth to contrib plugins..."
    export TAIGA_CONTRIB_PLUGINS="${TAIGA_CONTRIB_PLUGINS} gitlab-auth"
  else
    log "Taiga Front GitLab Auth enabled"
  fi
fi

if [ -n "$TAIGA_GITLAB_AUTH_CLIENT_ID" ]; then
  log "Updating Taiga Front GitLab Auth client id and URL: $TAIGA_GITLAB_AUTH_URL - $TAIGA_GITLAB_AUTH_CLIENT_ID"
  sed -i \
    -e "/gitLabClientId/c\    \"gitLabClientId\" : \"$TAIGA_GITLAB_AUTH_CLIENT_ID\"," \
    -e "/gitLabUrl/c\    \"gitLabUrl\" : \"$TAIGA_GITLAB_AUTH_URL\"," \
    /taiga/conf.json
fi

#########################################


#########################################
## GITHUB
#########################################

if [ "$TAIGA_ENABLE_GITHUB_AUTH" = "True" ]; then
  if ! echo "${TAIGA_CONTRIB_PLUGINS}" | grep 'github-auth'; then
    log "Adding Taiga Front GitHub Auth to contrib plugins..."
    export TAIGA_CONTRIB_PLUGINS="${TAIGA_CONTRIB_PLUGINS} github-auth"
  else
    log "Taiga Front GitHub Auth enabled"
  fi
fi

if [ -n "$TAIGA_GITHUB_AUTH_CLIENT_ID" ]; then
  log "Updating Taiga Front GitHub Auth client id: $TAIGA_GITHUB_AUTH_CLIENT_ID"
  sed -i \
    -e "/gitHubClientId/c\    \"gitHubClientId\" : \"$TAIGA_GITHUB_AUTH_CLIENT_ID\"," \
    /taiga/conf.json
fi

#########################################


#########################################
## OpenID Connect
#########################################

if [ "$TAIGA_ENABLE_OIDC_AUTH" = "True" ]; then
  if ! echo "${TAIGA_CONTRIB_PLUGINS}" | grep 'openid-auth'; then
    log "Adding Taiga Front OIDC Auth to contrib plugins..."
    export TAIGA_CONTRIB_PLUGINS="${TAIGA_CONTRIB_PLUGINS} openid-auth"
  else
    log "Taiga Front OIDC Auth enabled"
  fi
fi

if [ -n "$TAIGA_OIDC_AUTH_CLIENT_ID" ]; then
  log "Updating Taiga Front OIDC Auth client id: $TAIGA_OIDC_AUTH_CLIENT_ID"
  sed -i \
    -e "/openidAuth/c\    \"openidAuth\" : \"$TAIGA_OIDC_AUTH_AUTH_URL\"," \
    -e "/openidName/c\    \"openidName\" : \"$TAIGA_OIDC_AUTH_BUTTON_NAME\"," \
    -e "/openidClientId/c\    \"openidClientId\" : \"$TAIGA_OIDC_AUTH_CLIENT_ID\"," \
    /taiga/conf.json
fi

#########################################

# Remove any trailing commas
sed -i.bak ':begin;$!N;s/,\n}/\n}/g;tbegin;P;D' /taiga/conf.json
