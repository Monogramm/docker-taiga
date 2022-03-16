# If you want to modify this file, I recommend check out docker-taiga-example
# https://github.com/benhutchins/docker-taiga-example
#
# Please modify this file as needed, see the local.py.example for details:
# https://github.com/taigaio/taiga-back/blob/master/settings/local.py.example
#
# Importing docker provides common settings, see:
# https://github.com/benhutchins/docker-taiga/blob/master/docker-settings.py
# https://github.com/taigaio/taiga-back/blob/master/settings/common.py

from .docker import *
from ldap3 import Tls
import os, sys, ssl

#########################################
## SLACK
#########################################

if os.getenv('TAIGA_ENABLE_SLACK', os.getenv('ENABLE_SLACK', 'False')).lower() == 'true':
    # https://github.com/taigaio/taiga-contrib-slack
    print("Taiga contrib slack enabled", file=sys.stderr)
    INSTALLED_APPS += ["taiga_contrib_slack"]


#########################################
## GITLAB
#########################################

if os.getenv('TAIGA_ENABLE_GITLAB_AUTH', os.getenv('ENABLE_GITLAB_AUTH', 'False')).lower() == 'true':
    # see https://github.com/taigaio/taiga-contrib-gitlab-auth
    print("Taiga contrib GitLab Auth enabled", file=sys.stderr)
    INSTALLED_APPS += ["taiga_contrib_gitlab_auth"]

    # Get these from Admin -> Applications
    GITLAB_URL = os.getenv('TAIGA_GITLAB_AUTH_URL', os.getenv('GITLAB_URL'))
    GITLAB_API_CLIENT_ID = os.getenv('TAIGA_GITLAB_AUTH_CLIENT_ID', os.getenv('GITLAB_API_CLIENT_ID'))
    GITLAB_API_CLIENT_SECRET = os.getenv('TAIGA_GITLAB_AUTH_CLIENT_SECRET', os.getenv('GITLAB_API_CLIENT_SECRET'))


#########################################
## GITHUB
#########################################

if os.getenv('TAIGA_ENABLE_GITHUB_AUTH', os.getenv('ENABLE_GITHUB_AUTH', 'False')).lower() == 'true':
    # see https://github.com/taigaio/taiga-contrib-github-auth
    print("Taiga contrib GitHub Auth enabled", file=sys.stderr)
    INSTALLED_APPS += ["taiga_contrib_github_auth"]

    # Get these from https://github.com/settings/developers
    GITHUB_URL = "https://github.com/"
    GITHUB_API_URL = "https://api.github.com/"
    GITHUB_API_CLIENT_ID = os.getenv('TAIGA_GITHUB_AUTH_CLIENT_ID', os.getenv('GITHUB_API_CLIENT_ID'))
    GITHUB_API_CLIENT_SECRET = os.getenv('TAIGA_GITHUB_AUTH_CLIENT_SECRET', os.getenv('GITHUB_API_CLIENT_SECRET'))


#########################################
## OpenID Connect
#########################################

if os.getenv('TAIGA_ENABLE_OPENID_AUTH', os.getenv('ENABLE_OPENID', 'False')).lower() == 'true':
    print("Taiga contrib OpenID Auth enabled", file=sys.stderr)
    INSTALLED_APPS += ["taiga_contrib_openid_auth"]

    OPENID_USER_URL = os.getenv('TAIGA_OPENID_AUTH_USER_URL', os.getenv('OPENID_USER_URL'))
    OPENID_TOKEN_URL = os.getenv('TAIGA_OPENID_AUTH_TOKEN_URL', os.getenv('OPENID_TOKEN_URL'))
    OPENID_CLIENT_ID = os.getenv('TAIGA_OPENID_AUTH_CLIENT_ID', os.getenv('OPENID_CLIENT_ID'))
    OPENID_CLIENT_SECRET = os.getenv('TAIGA_OPENID_AUTH_CLIENT_SECRET', os.getenv('OPENID_CLIENT_SECRET'))
    OPENID_SCOPE = os.getenv('TAIGA_OPENID_SCOPE', os.getenv('OPENID_SCOPE'))


#########################################
## LDAP
#########################################

if os.getenv('TAIGA_ENABLE_LDAP', os.getenv('ENABLE_LDAP', 'False')).lower() == 'true':
    # see https://github.com/Monogramm/taiga-contrib-ldap-auth-ext
    print("Taiga contrib LDAP Auth Ext enabled", file=sys.stderr)
    INSTALLED_APPS += ["taiga_contrib_ldap_auth_ext"]

    if os.getenv('TAIGA_LDAP_USE_TLS', os.getenv('LDAP_START_TLS', 'False')).lower() == 'true':
        # Flag to enable LDAP with STARTTLS before bind
        LDAP_START_TLS = True
        LDAP_TLS_CERTS = Tls(validate=ssl.CERT_NONE, version=ssl.PROTOCOL_TLSv1, ciphers='RSA+3DES')
    else:
        LDAP_START_TLS = False

    LDAP_SERVER = os.getenv('TAIGA_LDAP_SERVER', os.getenv('LDAP_SERVER'))
    LDAP_PORT = int(os.getenv('TAIGA_LDAP_PORT', os.getenv('LDAP_PORT', '389')))

    # Full DN of the service account use to connect to LDAP server and search for login user's account entry
    # If LDAP_BIND_DN is not specified, or is blank, then an anonymous bind is attempated
    LDAP_BIND_DN = os.getenv('TAIGA_LDAP_BIND_DN', os.getenv('LDAP_BIND_DN'))
    LDAP_BIND_PASSWORD = os.getenv('TAIGA_LDAP_BIND_PASSWORD', os.getenv('LDAP_BIND_PASSWORD'))

    # Starting point within LDAP structure to search for login user
    # Something like 'ou=People,dc=company,dc=com'
    LDAP_SEARCH_BASE = os.getenv('TAIGA_LDAP_BASE_DN', os.getenv('LDAP_SEARCH_BASE'))

    # Additional search criteria to the filter (will be ANDed)
    #LDAP_SEARCH_FILTER_ADDITIONAL = '(mail=*)'

    # Names of attributes to get username, e-mail and full name values from
    # These fields need to have a value in LDAP
    LDAP_USERNAME_ATTRIBUTE = os.getenv('TAIGA_LDAP_USERNAME_ATTRIBUTE', os.getenv('LDAP_USERNAME_ATTRIBUTE'))
    LDAP_EMAIL_ATTRIBUTE = os.getenv('TAIGA_LDAP_EMAIL_ATTRIBUTE', os.getenv('LDAP_EMAIL_ATTRIBUTE'))
    LDAP_FULL_NAME_ATTRIBUTE = os.getenv('TAIGA_LDAP_FULL_NAME_ATTRIBUTE', os.getenv('LDAP_FULL_NAME_ATTRIBUTE'))

    # Option to not store the passwords in the local db
    if os.getenv('TAIGA_LDAP_SAVE_LOGIN_PASSWORD', os.getenv('LDAP_SAVE_LOGIN_PASSWORD', 'False')).lower() == 'false':
        LDAP_SAVE_LOGIN_PASSWORD = False

    # Fallback on normal authentication method if this LDAP auth fails. Uncomment to enable.
    LDAP_FALLBACK = os.getenv('TAIGA_LDAP_FALLBACK', os.getenv('LDAP_FALLBACK', 'normal'))

    # Function to map LDAP username to local DB user unique identifier.
    # Upon successful LDAP bind, will override returned username attribute
    # value. May result in unexpected failures if changed after the database
    # has been populated.
    def _ldap_slugify(uid: str) -> str:
        # example: force lower-case
        uid = uid.lower()
        return uid

    LDAP_MAP_USERNAME_TO_UID = _ldap_slugify

    ## For additional configuration options, look at:
    # https://github.com/taigaio/taiga-back/blob/master/settings/local.py.example
