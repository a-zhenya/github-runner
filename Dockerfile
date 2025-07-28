FROM ubuntu:latest

LABEL maintainer="Evgeny A"
LABEL version=1.0

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl git sudo gzip ca-certificates software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* 
RUN useradd -M -d / runner && install -o runner -g runner -d /wrk
WORKDIR /wrk
ENV ACTIONS_RUNNER_VERSION=2.326.0
ENV ACTIONS_RUNNER_SHA=9c74af9b4352bbc99aecc7353b47bcdfcd1b2a0f6d15af54a99f54a0c14a1de8
RUN sudo -u runner curl -sL -o actions-runner.tar.gz \
    https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz \
    && sudo -u runner echo "${ACTIONS_RUNNER_SHA}  actions-runner.tar.gz" | sha256sum -c - \
    && sudo -u runner tar xzf ./actions-runner.tar.gz \
    && sudo -u runner rm -f ./actions-runner.tar.gz 
COPY entrypoint.sh ./
USER runner
CMD ["/bin/sh", "entrypoint.sh"]
