
[uri_license]: http://www.gnu.org/licenses/agpl.html
[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg

[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-taiga.svg)](https://travis-ci.org/Monogramm/docker-taiga)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-taiga.svg)](https://hub.docker.com/r/monogramm/docker-taiga/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-taiga.svg)](https://hub.docker.com/r/monogramm/docker-taiga/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-taiga.svg)](https://microbadger.com/images/monogramm/docker-taiga)
[![](https://images.microbadger.com/badges/image/monogramm/docker-taiga.svg)](https://microbadger.com/images/monogramm/docker-taiga)

# Docker image for taiga-front

This Docker repository provides a custom [taiga-front](https://github.com/taigaio/taiga-front) and [taiga-back](https://github.com/taigaio/taiga-back).

:construction: **This repository is still in development!**

This image was inspired by [ajira86/docker-taiga](https://github.com/ajira86/docker-taiga) which is a fork of [benhutchins/docker-taiga](https://github.com/benhutchins/docker-taiga).

## What is Taiga?

Taiga is a project management platform for startups and agile developers & designers who want a simple, beautiful tool that makes work truly enjoyable.

> [taiga.io](https://taiga.io)

## Build Docker-compose

To generate docker images from the template, execute `update.sh` script.

Install Docker and then run `cd images/VARIANT/VERSION && docker-compose build` to build the images for the variant and version you need.

You can also build all images by running `update.sh build`.

## Run Docker-compose

Install Docker and then run `cd images/VARIANT/VERSION && docker-compose up -d` to run the images for the variant and version you need.
