#!/bin/sh

./config.sh --unattended --url "$REPO_URL" --token "$TOKEN" --name "$RUNNER_NAME"

./run.sh

if [ -f /tmp/remove_token ]; then
  REMOVE="$(cat /tmp/remove_token)"
  ./config.sh remove --token $REMOVE
else
  echo No remove_token found
  exit 1
fi
