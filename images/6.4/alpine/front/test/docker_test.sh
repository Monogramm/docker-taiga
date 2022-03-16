#!/bin/sh

set -e

log() {
    echo "[$0] [$(date +%Y-%m-%dT%H:%M:%S)] $*"
}

################################################################################
# Testing docker containers

log "Waiting to ensure everything is fully ready for the tests..."
sleep 180

log "Checking main containers are reachable..."
if ! ping -c 10 -q "${DOCKER_TEST_CONTAINER}" ; then
    log 'Main container is not responding!'
    # TODO Display logs to help bug fixing
    #log 'Check the following logs for details:'
    #tail -n 100 logs/*.log
    exit 2
fi


################################################################################
# Success
log 'Docker tests successful'


################################################################################
# Automated Unit tests
# https://docs.docker.com/docker-hub/builds/automated-testing/
################################################################################

# Check API is responding
if [ -n "${DOCKER_WEB_CONTAINER}" ]; then

    if ! ping -c 10 -q "${DOCKER_WEB_CONTAINER}" ; then
        log 'Web container is not responding!'
        # TODO Display logs to help bug fixing
        #log 'Check the following logs for details:'
        #tail -n 100 logs/*.log
        exit 2
    fi

    DOCKER_WEB_CONTAINER_HEALTH_URL=http://${DOCKER_WEB_CONTAINER}:${DOCKER_WEB_PORT:-80}/${DOCKER_WEB_HEALTH_API:-conf.json}
    log "Checking conf.json: ${DOCKER_WEB_CONTAINER_HEALTH_URL}"
    curl --fail "${DOCKER_WEB_CONTAINER_HEALTH_URL}" | grep -q -e 'defaultTheme' || exit 1
fi


################################################################################
# Success
log "Docker app '${DOCKER_TEST_CONTAINER}' tests finished"
log 'Check the CI reports and logs for details.'
exit 0
