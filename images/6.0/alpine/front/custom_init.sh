#!/bin/sh
set -e

#log() {
#  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $@"
#}


#########################################
## GITLAB
#########################################

if [ "${TAIGA_ENABLE_GITLAB_AUTH}" = "True" ]; then
  if ! echo "${TAIGA_CONTRIB_PLUGINS}" | grep 'gitlab-auth'; then
    log "Adding Taiga Front GitLab Auth to contrib plugins..."
    export TAIGA_CONTRIB_PLUGINS="${TAIGA_CONTRIB_PLUGINS} gitlab-auth"
  else
    log "Taiga Front GitLab Auth enabled"
  fi
fi

if [ -n "${TAIGA_GITLAB_AUTH_CLIENT_ID}" ]; then
  log "Updating Taiga Front GitLab Auth client id and URL: ${TAIGA_GITLAB_AUTH_URL} - ${TAIGA_GITLAB_AUTH_CLIENT_ID}"
  sed -i \
    -e "s|\"gitLabClientId\": \".*\"|\"gitLabClientId\": \"${TAIGA_GITLAB_AUTH_CLIENT_ID}\"|g" \
    -e "s|\"gitLabUrl\": \".*\"|\"gitLabUrl\": \"${TAIGA_GITLAB_AUTH_URL}\"|g" \
    /taiga/conf.json
fi

#########################################


#########################################
## GITHUB
#########################################

if [ "${TAIGA_ENABLE_GITHUB_AUTH}" = "True" ]; then
  if ! echo "${TAIGA_CONTRIB_PLUGINS}" | grep 'github-auth'; then
    log "Adding Taiga Front GitHub Auth to contrib plugins..."
    export TAIGA_CONTRIB_PLUGINS="${TAIGA_CONTRIB_PLUGINS} github-auth"
  else
    log "Taiga Front GitHub Auth enabled"
  fi
fi

if [ -n "${TAIGA_GITHUB_AUTH_CLIENT_ID}" ]; then
  log "Updating Taiga Front GitHub Auth client id: ${TAIGA_GITHUB_AUTH_CLIENT_ID}"
  sed -i \
    -e "s|\"gitHubClientId\": \".*\"|\"gitHubClientId\": \"${TAIGA_GITHUB_AUTH_CLIENT_ID}\"|g" \
    /taiga/conf.json
fi

#########################################
