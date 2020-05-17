[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-taiga.svg)](https://travis-ci.org/Monogramm/docker-taiga)

**docker-taiga-front**

[![Front Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)
[![Front Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-front.svg)](https://microbadger.com/images/monogramm/docker-taiga-front)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-front.svg)](https://microbadger.com/images/monogramm/docker-taiga-front)

* * *

**docker-taiga-back**

[![Back Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)
[![Back Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-back.svg)](https://microbadger.com/images/monogramm/docker-taiga-back)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-back.svg)](https://microbadger.com/images/monogramm/docker-taiga-back)

* * *

# Docker image for taiga

This Docker repository provides custom [taiga-front](https://github.com/taigaio/taiga-front) and [taiga-back](https://github.com/taigaio/taiga-back) docker images with additional plugins and a production ready docker-compose.

These images were inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

## What is Taiga?

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)

## Supported tags

> [docker-taiga-front](https://hub.docker.com/r/monogramm/docker-taiga-front/)

> [docker-taiga-back](https://hub.docker.com/r/monogramm/docker-taiga-back/)

-   `4.0`, `4.0-alpine`
-   `4.1`, `4.1-alpine`
-   `4.2`, `4.2-alpine`, `4`, `4-alpine`
-   `5.0`, `5.0-alpine`, `5`, `5-alpine`, `alpine`, `latest`

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

### Frontend Auto configuration via environment variables

The Taiga frontend image supports auto configuration via environment variables. You can preconfigure nearly everything that is available in `conf.json`.

See [docker-taiga-front-base](https://github.com/Monogramm/docker-taiga-front-base/) for more details on configuration.

This image also provides healthchecks and additionnal configuration properties.

#### TAIGA_GITLAB_AUTH_CLIENT_ID

_Default value_: 

GitLab Authentication client ID. Remember to set `TAIGA_CONTRIB_PLUGINS=gitlab-auth` too.

Examples:

```yml
TAIGA_GITLAB_AUTH_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITLAB_AUTH_XXXXXX
```

#### TAIGA_GITLAB_AUTH_URL

_Default value_: `https://gitlab.com`

GitLab Authentication instance URL.

Examples:

```yml
TAIGA_GITLAB_AUTH_URL=https://gitlab.com
```

```yml
TAIGA_GITLAB_AUTH_URL=https://gitlab.company.com
```

#### TAIGA_GITHUB_AUTH_CLIENT_ID

_Default value_: 

GitHub Authentication client ID. Remember to set `TAIGA_CONTRIB_PLUGINS=github-auth` too.

Examples:

```yml
TAIGA_GITHUB_AUTH_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITHUB_AUTH_XXXXXX
```

## Backend

The image is based on [Monogramm/docker-taiga-back-base](https://github.com/Monogramm/docker-taiga-back-base) and add the following plugins:

-   <https://github.com/taigaio/taiga-contrib-slack>
-   <https://github.com/taigaio/taiga-contrib-gitlab-auth>
-   <https://github.com/taigaio/taiga-contrib-github-auth>
-   <https://github.com/Monogramm/taiga-contrib-ldap-auth-ext>

### Backend Auto configuration via environment variables

The Taiga image supports auto configuration via environment variables. You can preconfigure nearly everything that is available in `local.py`.

See [docker-taiga-back-base](https://github.com/Monogramm/docker-taiga-back-base/) for more details on configuration.

This image also provides healthchecks and additionnal configuration properties.

#### TAIGA_ENABLE_SLACK

_Default value_: `False`

Enable Taiga Slack plugin (also compatible with Mattermost). Remember to set `TAIGA_CONTRIB_PLUGINS=slack` in the frontend too.

Examples:

```yml
TAIGA_ENABLE_SLACK=False
TAIGA_ENABLE_SLACK=True
```

#### TAIGA_ENABLE_GITLAB_AUTH

_Default value_: `False`

Enable Taiga GitLab Authentication. Remember to set `TAIGA_CONTRIB_PLUGINS=gitlab-auth` and `TAIGA_GITLAB_AUTH_CLIENT_ID` in the frontend too.

Examples:

```yml
TAIGA_ENABLE_GITLAB_AUTH=False
```

```yml
TAIGA_ENABLE_GITLAB_AUTH=True
TAIGA_GITLAB_AUTH_URL=https://gitlab.com
TAIGA_GITLAB_AUTH_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITLAB_AUTH_XXXXXX
TAIGA_GITLAB_AUTH_CLIENT_SECRET=XXXXXX_get_a_valid_client_secret_from_GITLAB_AUTH_XXXXXX
```

#### TAIGA_ENABLE_GITHUB_AUTH

_Default value_: `False`

Enable Taiga GitHub Authentication. Remember to set `TAIGA_CONTRIB_PLUGINS=github-auth` and `TAIGA_GITHUB_AUTH_CLIENT_ID` in the frontend too.

Examples:

```yml
TAIGA_ENABLE_GITHUB_AUTH=False
```

```yml
TAIGA_ENABLE_GITHUB_AUTH=True
TAIGA_GITHUB_AUTH_CLIENT_ID=XXXXXX_get_a_valid_client_id_from_GITHUB_AUTH_XXXXXX
TAIGA_GITHUB_AUTH_CLIENT_SECRET=XXXXXX_get_a_valid_client_secret_from_GITHUB_AUTH_XXXXXX
```

#### TAIGA_ENABLE_LDAP

_Default value_: `False`

Enable Taiga LDAP Authentication. Remember to set `TAIGA_LOGIN_FORM_TYPE=ldap` in the frontend too.

Examples:

```yml
TAIGA_ENABLE_LDAP=False
```

```yml
TAIGA_ENABLE_LDAP=True
# LDAP over STARTTLS
TAIGA_LDAP_USE_TLS=True
TAIGA_LDAP_SERVER=ldap.company.com
TAIGA_LDAP_PORT=389
# LDAP bind and lookup properties
TAIGA_LDAP_BIND_DN=cn=admin,dc=ldap,dc=company,dc=com
TAIGA_LDAP_BIND_PASSWORD=somethingreallysecure
TAIGA_LDAP_BASE_DN=ou=People,dc=ldap,dc=company,dc=com
TAIGA_LDAP_USERNAME_ATTRIBUTE=uid
TAIGA_LDAP_EMAIL_ATTRIBUTE=mail
TAIGA_LDAP_FULL_NAME_ATTRIBUTE=cn
# Fallback to local users if login not found in LDAP (default behavior)
TAIGA_LDAP_FALLBACK=normal
```

```yml
TAIGA_ENABLE_LDAP=True
# LDAP over SSL
TAIGA_LDAP_USE_TLS=False
TAIGA_LDAP_SERVER=ldaps://ldap.company.com
TAIGA_LDAP_PORT=636
# LDAP bind and lookup properties
TAIGA_LDAP_BIND_DN=cn=admin,dc=ldap,dc=company,dc=com
TAIGA_LDAP_BIND_PASSWORD=somethingreallysecure
TAIGA_LDAP_BASE_DN=ou=People,dc=ldap,dc=company,dc=com
TAIGA_LDAP_USERNAME_ATTRIBUTE=uid
TAIGA_LDAP_EMAIL_ATTRIBUTE=mail
TAIGA_LDAP_FULL_NAME_ATTRIBUTE=cn
# Disable passwords saved in DB on LDAP login
TAIGA_LDAP_SAVE_LOGIN_PASSWORD=False
# No fallback to local users (ie LDAP only)
TAIGA_LDAP_FALLBACK=
```

[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg
