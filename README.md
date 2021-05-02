[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-taiga.svg)](https://travis-ci.org/Monogramm/docker-taiga)

**docker-taiga-front**

[![Front Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)
[![Front Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)

* * *

**docker-taiga-back**

[![Back Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)
[![Back Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)

* * *

# Docker image for taiga

This Docker repository provides custom [taiga-front](https://github.com/taigaio/taiga-front) and [taiga-back](https://github.com/taigaio/taiga-back) docker images with additional plugins and a production ready docker-compose.

These images were inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

## What is Taiga

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)

## Supported tags

> [monogramm/docker-taiga-front](https://hub.docker.com/r/monogramm/docker-taiga-front/)

> [monogramm/docker-taiga-back](https://hub.docker.com/r/monogramm/docker-taiga-back/)

<!-- >Docker Tags -->

-   6.0.10-alpine 6.0-alpine alpine 6.0.10 6.0 latest  (`images/6.0/alpine/front/Dockerfile`) ![Docker Image Size (6.0.10-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-front/6.0.10-alpine)
-   6.0.10-alpine 6.0-alpine alpine 6.0.10 6.0 latest  (`images/6.0/alpine/back/Dockerfile`) ![Docker Image Size (6.0.10-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-back/6.0.10-alpine)
-   5.5.10-alpine 5.5-alpine 5.5.10 5.5  (`images/5.5/alpine/front/Dockerfile`) ![Docker Image Size (5.5.10-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-front/5.5.10-alpine)
-   5.5.10-alpine 5.5-alpine 5.5.10 5.5  (`images/5.5/alpine/back/Dockerfile`) ![Docker Image Size (5.5.10-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-back/5.5.10-alpine)
-   5.0.15-alpine 5.0-alpine 5.0.15 5.0  (`images/5.0/alpine/front/Dockerfile`) ![Docker Image Size (5.0.15-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-front/5.0.15-alpine)
-   5.0.15-alpine 5.0-alpine 5.0.15 5.0  (`images/5.0/alpine/back/Dockerfile`) ![Docker Image Size (5.0.15-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-back/5.0.15-alpine)
-   4.2.14-alpine 4.2-alpine 4.2.14 4.2  (`images/4.2/alpine/front/Dockerfile`) ![Docker Image Size (4.2.14-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-front/4.2.14-alpine)
-   4.2.14-alpine 4.2-alpine 4.2.14 4.2  (`images/4.2/alpine/back/Dockerfile`) ![Docker Image Size (4.2.14-alpine)](https://img.shields.io/docker/image-size/monogramm/docker-taiga-back/4.2.14-alpine)

<!-- <Docker Tags -->

## Build Docker-compose

To generate docker images from the template, execute `update.sh` script.

Install Docker and then run `cd images/VARIANT/VERSION && docker-compose build` to build the images for the variant and version you need.

You can also build all images by running `update.sh build`.

## Run Docker-compose

-   Run `cd images/VARIANT/VERSION` for the variant and version you need
-   Edit the `.env` file with your environment information
-   (Optional) Comment the `build: ` and uncomment the `image: ` to use official images and not build from local Dockerfile
-   Run `docker-compose up -d` to start the containers

## Frontend

The front is based on [Monogramm/docker-taiga-front-base](https://github.com/Monogramm/docker-taiga-front-base) and adds the following plugins:

-   <https://github.com/taigaio/taiga-contrib-slack>
-   <https://github.com/taigaio/taiga-contrib-gitlab-auth>
-   <https://github.com/taigaio/taiga-contrib-github-auth>
-   <https://github.com/taigaio/taiga-contrib-cookie-warning>
-   <https://github.com/robrotheram/taiga-contrib-openid-auth>

### Frontend Auto configuration via environment variables

The Taiga frontend image supports auto configuration via environment variables. You can preconfigure nearly everything that is available in `conf.json`.

See [docker-taiga-front-base](https://github.com/Monogramm/docker-taiga-front-base/) for more details on configuration.

This image also provides healthchecks and additionnal configuration properties.

#### GITLAB_API_CLIENT_ID

_Default value_: 

GitLab Authentication client ID. Remember to set `TAIGA_CONTRIB_PLUGINS=gitlab-auth` too.

Examples:

```yml
GITLAB_API_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITLAB_AUTH_XXXXXX
```

#### GITLAB_URL

_Default value_: `https://gitlab.com`

GitLab Authentication instance URL.

Examples:

```yml
GITLAB_URL=https://gitlab.com
```

```yml
GITLAB_URL=https://gitlab.company.com
```

#### GITHUB_AUTH_CLIENT_ID

_Default value_: 

GitHub Authentication client ID. Remember to set `TAIGA_CONTRIB_PLUGINS=github-auth` too.

Examples:

```yml
GITHUB_AUTH_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITHUB_AUTH_XXXXXX
```

#### OPENID_CLIENT_ID

_Default value_: 

OpenID Authentication client ID. Remember to set `TAIGA_CONTRIB_PLUGINS=openid-auth` too.

Examples:

```yml
OPENID_URL=https://{url-to-keycloak}/auth/realms/{realm}/protocol/openid-connect/auth
OPENID_NAME=Name_you_want_to_give_your_openid_provider_eg_keycloak
OPENID_CLIENT_ID=Client_ID
```

## Backend

The image is based on [Monogramm/docker-taiga-back-base](https://github.com/Monogramm/docker-taiga-back-base) and add the following plugins:

-   <https://github.com/taigaio/taiga-contrib-slack>
-   <https://github.com/taigaio/taiga-contrib-gitlab-auth>
-   <https://github.com/taigaio/taiga-contrib-github-auth>
-   <https://github.com/Monogramm/taiga-contrib-ldap-auth-ext>
-   <https://github.com/robrotheram/taiga-contrib-openid-auth>

### Backend Auto configuration via environment variables

The Taiga image supports auto configuration via environment variables. You can preconfigure nearly everything that is available in `local.py`.

See [docker-taiga-back-base](https://github.com/Monogramm/docker-taiga-back-base/) for more details on configuration.

This image also provides healthchecks and additionnal configuration properties.

#### ENABLE_SLACK

_Default value_: `False`

Enable Taiga Slack plugin (also compatible with Mattermost). Remember to set `TAIGA_CONTRIB_PLUGINS=slack` in the frontend too.

Examples:

```yml
ENABLE_SLACK=False
ENABLE_SLACK=True
```

#### ENABLE_GITLAB_AUTH

_Default value_: `False`

Enable Taiga GitLab Authentication. Remember to set `TAIGA_CONTRIB_PLUGINS=gitlab-auth` and `TAIGA_GITLAB_AUTH_CLIENT_ID` in the frontend too.

Examples:

```yml
ENABLE_GITLAB_AUTH=False
```

```yml
ENABLE_GITLAB_AUTH=True
GITLAB_URL=https://gitlab.com
GITLAB_API_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITLAB_AUTH_XXXXXX
GITLAB_API_CLIENT_SECRET=XXXXXX_get_a_valid_client_secret_from_GITLAB_AUTH_XXXXXX
```

#### ENABLE_GITHUB_AUTH

_Default value_: `False`

Enable Taiga GitHub Authentication. Remember to set `TAIGA_CONTRIB_PLUGINS=github-auth` and `TAIGA_GITHUB_AUTH_CLIENT_ID` in the frontend too.

Examples:

```yml
ENABLE_GITHUB_AUTH=False
```

```yml
ENABLE_GITHUB_AUTH=True
GITHUB_API_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITHUB_AUTH_XXXXXX
GITHUB_API_CLIENT_SECRET=XXXXXX_get_a_valid_client_secret_from_GITHUB_AUTH_XXXXXX
```

#### ENABLE_LDAP

_Default value_: `False`

Enable Taiga LDAP Authentication. Remember to set `TAIGA_LOGIN_FORM_TYPE=ldap` in the frontend too.

Examples:

```yml
ENABLE_LDAP=False
```

```yml
ENABLE_LDAP=True
# LDAP over STARTTLS
LDAP_START_TLS=True
LDAP_SERVER=ldap.company.com
LDAP_PORT=389
# LDAP bind and lookup properties
LDAP_BIND_DN=cn=admin,dc=ldap,dc=company,dc=com
LDAP_BIND_PASSWORD=somethingreallysecure
LDAP_SEARCH_BASE=ou=People,dc=ldap,dc=company,dc=com
LDAP_USERNAME_ATTRIBUTE=uid
LDAP_EMAIL_ATTRIBUTE=mail
LDAP_FULL_NAME_ATTRIBUTE=cn
# Fallback to local users if login not found in LDAP (default behavior)
LDAP_FALLBACK=normal
```

```yml
ENABLE_LDAP=True
# LDAP over SSL
LDAP_START_TLS=False
LDAP_SERVER=ldaps://ldap.company.com
LDAP_PORT=636
# LDAP bind and lookup properties
LDAP_BIND_DN=cn=admin,dc=ldap,dc=company,dc=com
LDAP_BIND_PASSWORD=somethingreallysecure
LDAP_SEARCH_BASE=ou=People,dc=ldap,dc=company,dc=com
LDAP_USERNAME_ATTRIBUTE=uid
LDAP_EMAIL_ATTRIBUTE=mail
TAIGA_LDAP_FULL_NAME_ATTRIBUTE=cn
# Disable passwords saved in DB on LDAP login
LDAP_SAVE_LOGIN_PASSWORD=False
# No fallback to local users (ie LDAP only)
LDAP_FALLBACK=
```

#### ENABLE_OPENID

_Default value_: `False`

Enable Taiga OpenID Authentication. Remember to set `TAIGA_CONTRIB_PLUGINS=openid-auth` and `TAIGA_OPENID_AUTH_URL` / `TAIGA_OPENID_AUTH_NAME` / `TAIGA_OPENID_AUTH_CLIENT_ID` in the frontend too.

Examples:

```yml
ENABLE_OPENID=False
```

```yml
ENABLE_OPENID=True
OPENID_USER_URL=https://{url-to-keycloak}/auth/realms/{realm}/protocol/openid-connect/auth
OPENID_TOKEN_URL=https://{url-to-keycloak}/auth/realms/{realm}/protocol/openid-connect/token
OPENID_CLIENT_ID=Client_ID
OPENID_CLIENT_SECRET=Client_SECRET
OPENID_SCOPE=openid email
```

[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg
