#!/bin/sh
set -e

log() {
  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $@"
}

# ------------------------------------------------------------------------------
# Custom database init script

#########################################
## SLACK
#########################################

log "Run contrib Slack plugin migrations to generate the new needed table..."
python manage.py migrate taiga_contrib_slack
log "Contrib Slack plugin migrations applied."

#########################################
