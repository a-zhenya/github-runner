#!/bin/sh

REPO=a-zhenya/test 
API_URL="/repos/${REPO}/actions/runners/remove-token" 
if command -v gh >/dev/null ; then
	TOKEN=$(gh api -X POST "$API_URL" --jq .token)
else
	TOKEN=$(curl -sS -X POST -H "Authorization: token $GH_TOKEN" "https://api.github.com$API_URL" | jq -r .token)
fi
NAME=runner-$(curl -s "https://www.random.org/integers/?num=1&min=100000&max=999999&col=1&base=10&format=plain&rnd=new")

docker run --detach --rm --name "$NAME" \
    -e REPO_URL=https://github.com/$REPO \
    -e TOKEN=$TOKEN \
    -e RUNNER_NAME=$NAME \
    github-runner:latest && echo $NAME
