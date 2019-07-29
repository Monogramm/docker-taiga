#!/bin/sh
set -e


#########################################
## GITLAB
#########################################

if [ -n "$TAIGA_GITLAB_AUTH_CLIENT_ID" ]; then
  log "Updating Taiga Front GitLab client id and URL: $TAIGA_GITLAB_AUTH_URL - $TAIGA_GITLAB_AUTH_CLIENT_ID"
  sed -i \
    -e "s|\"gitLabClientId\": \".*\"|\"gitLabClientId\": \"$TAIGA_GITLAB_AUTH_CLIENT_ID\"|g" \
    -e "s|\"gitLabUrl\": \".*\"|\"gitLabUrl\": \"$TAIGA_GITLAB_AUTH_URL\"|g" \
    /taiga/conf.json
fi

#########################################


#########################################
## GITHUB
#########################################

if [ -n "$TAIGA_GITHUB_AUTH_CLIENT_ID" ]; then
  log "Updating Taiga Front GitHub client id: $TAIGA_GITHUB_AUTH_CLIENT_ID"
  sed -i \
    -e "s|\"gitHubClientId\": \".*\"|\"gitHubClientId\": \"$TAIGA_GITHUB_AUTH_CLIENT_ID\"|g" \
    /taiga/conf.json
fi

#########################################
