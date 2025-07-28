#!/bin/sh

./config.sh --unattended --url $REPO_URL --token $TOKEN --name $RUNNER_NAME

./run.sh

if [ -f /tmp/remove_token ]; then
  REMOVE=$(cat /tmp/remove_token)
fi
./config.sh remove --token $REMOVE
