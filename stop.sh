#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 <runner-name>"
  exit 1
fi
RUNNER_NAME="$1"
REPO=a-zhenya/test
API_URL="/repos/${REPO}/actions/runners/remove-token" 
if command -v gh >/dev/null ; then
	TOKEN="$(gh api -X POST "$API_URL" --jq .token)"
else
	TOKEN="$(curl -sS -X POST -H "Authorization: token $GH_TOKEN" "https://api.github.com$API_URL" | jq -r .token)"
fi

docker exec "$RUNNER_NAME" sh -c "echo $TOKEN >/tmp/remove_token"
docker exec "$RUNNER_NAME" sh -c 'kill `pidof Runner.Listener`'
