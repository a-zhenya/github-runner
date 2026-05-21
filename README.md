# GitHub Runner

## Installation
1. Clone this repository
2. Change the target repo name in `start.sh`
3. Build an image with `build.sh`

## Spawn a runner
1. Ensure you have [GitHub CLI tool](https://cli.github.com/) installed and authorized.
   Alternatively, if you don't want to install `gh`, set GH_TOKEN environment variable.
2. Run `start.sh`. This will create a container and attach the runner to the selected repo

## Stop and delete a runner
1. Find your container name with `docker ps`
2. Run `stop.sh CONTAINER-NAME`. This will remove the container and delete it's token from the repo

## More info on runners
https://docs.github.com/en/actions/reference/runners/self-hosted-runners

## More info on github API
https://docs.github.com/en/rest

## More info on gh
https://cli.github.com/manual/

