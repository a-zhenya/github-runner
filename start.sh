#!/bin/sh

REPO=a-zhenya/test 
TOKEN=$(gh api -X POST /repos/${REPO}/actions/runners/remove-token --jq .token)
NAME=runner-$(curl -s "https://www.random.org/integers/?num=1&min=100000&max=999999&col=1&base=10&format=plain&rnd=new")

docker run --detach --rm --name "$NAME" \
    -e REPO_URL=https://github.com/$REPO \
    -e TOKEN=$TOKEN \
    -e RUNNER_NAME=$NAME \
    github-runner:latest && echo $NAME
