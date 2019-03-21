
[uri_license]: http://www.gnu.org/licenses/agpl.html
[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg

[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-taiga.svg)](https://travis-ci.org/Monogramm/docker-taiga)

Frontend
------------
[![Front Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)
[![Front Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-front.svg)](https://hub.docker.com/r/monogramm/docker-taiga-front/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-front.svg)](https://microbadger.com/images/monogramm/docker-taiga-front)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-front.svg)](https://microbadger.com/images/monogramm/docker-taiga-front)

Backend
------------
[![Back Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)
[![Back Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga-back.svg)](https://hub.docker.com/r/monogramm/docker-taiga-back/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga-back.svg)](https://microbadger.com/images/monogramm/docker-taiga-back)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga-back.svg)](https://microbadger.com/images/monogramm/docker-taiga-back)

# Docker image for taiga

This Docker repository provides a custom [taiga-front](https://github.com/taigaio/taiga-front), [taiga-back](https://github.com/taigaio/taiga-back) and [taiga-events](https://github.com/taigaio/taiga-events) with a production ready docker-compose.

:construction: **This repository is still in development!**

This image was inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

It is based on [Monogramm/docker-taiga-front-base](https://github.com/Monogramm/docker-taiga-front-base), [Monogramm/docker-taiga-back-base](https://github.com/Monogramm/docker-taiga-back-base) and [Monogramm/docker-taiga-events](https://github.com/Monogramm/docker-taiga-events).
The following plugins have been added:
* https://github.com/taigaio/taiga-contrib-slack
* https://github.com/taigaio/taiga-contrib-gitlab-auth
* https://github.com/taigaio/taiga-contrib-github-auth
* https://github.com/taigaio/taiga-contrib-cookie-warning
* https://github.com/Monogramm/taiga-contrib-ldap-auth-ext

## What is Taiga?

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)

## Build Docker-compose

To generate docker images from the template, execute `update.sh` script.

Install Docker and then run `cd images/VARIANT/VERSION && docker-compose build` to build the images for the variant and version you need.

You can also build all images by running `update.sh build`.

## Run Docker-compose

* Run `cd images/VARIANT/VERSION` for the variant and version you need;
* Edit the `.env` file with your environment information;
* Run `docker-compose up -d` to start the containers.
