#!/bin/bash

set -eu
# Ensure we have some virus data, otherwise clamd refuses to start
if [ ! -f "/var/lib/clamav/main.cvd" ]; then
    echo "Updating initial database"
    freshclam --foreground --stdout
fi

# start supervisord in the background and wait until it started
/usr/bin/supervisord &
until supervisorctl status; do
    echo "supervisord still starting.."
done
echo "supervisord" started

# Wait until supervisor has started all apps
while [ "$(supervisorctl status | grep -c "STARTING")" -gt 0 ]; do
    supervisorctl status
    if [ "${timeout:=0}" -gt "${SUPERVISOR_STARTUP_TIME:=30}" ]; then
        echo
        echo "Supervisor took longer than ${SUPERVISOR_STARTUP_TIME} to start.. exiting"
        exit 1
    fi
    echo "Supervisor still starting some apps, retrying (${timeout}/${SUPERVISOR_STARTUP_TIME}) ..."
    sleep 1
    timeout="$((timeout + 1))"
done
echo "Supervisor has started all apps"

# Check if Api.dll exists
if [ ! -f "/app/Api.dll" ]; then
    echo "Error: Api.dll not found in /app directory"
    exit 1
fi

# Echo out all files in the /app directory
echo "Files in /app directory:"
ls /app

# start dotnet app
cd /app
dotnet "${DLL_PATH:-Api.dll}"
