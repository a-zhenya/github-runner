#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 <runner-name>"
  exit 1
fi
RUNNER_NAME=$1
REPO=a-zhenya/test
TOKEN=$(gh api -X POST /repos/${REPO}/actions/runners/remove-token --jq .token)

docker exec $RUNNER_NAME sh -c "echo $TOKEN > /tmp/remove_token"
docker exec $RUNNER_NAME sh -c 'kill `pidof Runner.Listener`'
