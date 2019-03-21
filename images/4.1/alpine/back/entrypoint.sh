#!/bin/sh

# Sleep when asked to, to allow the database time to start
# before Taiga tries to run /checkdb.py below.
: ${TAIGA_SLEEP:=0}
sleep $TAIGA_SLEEP

# Setup database automatically if needed
if [ -z "$TAIGA_SKIP_DB_CHECK" ]; then
  echo "Running database check"
  python /checkdb.py
  DB_CHECK_STATUS=$?

  if [ $DB_CHECK_STATUS -eq 1 ]; then
    echo "Failed to connect to database server or database does not exist."
    exit 1
  fi

  if [ $DB_CHECK_STATUS -eq 2 ]; then
    echo "Configuring initial database"
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py loaddata initial_role

    if [ -n $TAIGA_ADMIN_PASSWORD ]; then
      echo "Changing initial admin password"
      python manage.py shell < changeadminpasswd.py
    fi


    #########################################
    ## SLACK
    #########################################

    # Run Slack contrib migrations to generate the new need table 
    python manage.py migrate taiga_contrib_slack

    #########################################
  fi

  # Database migration check should be done in all startup in case of backend upgrade
  echo "Execute database migrations..."
  python manage.py migrate --noinput

  # TODO Generate migrations and execute if needed
  #echo "Generate database migrations..."
  #python manage.py makemigrations
  #python manage.py migrate --noinput

fi

# In case of frontend upgrade, locales and statics should be regenerated
echo "Compiling messages and collecting static"
python manage.py compilemessages > /dev/null
python manage.py collectstatic --noinput > /dev/null

echo "Start gunicorn server"
exec "$@"
