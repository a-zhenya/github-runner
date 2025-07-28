#!/bin/sh

REPO=a-zhenya/test 
docker run --detach --rm --name action-runner \
    -e REPO_URL=https://github.com/$REPO \
    -e TOKEN=$(gh api -X POST /repos/$REPO/actions/runners/registration-token --jq .token) github-runner:latest
