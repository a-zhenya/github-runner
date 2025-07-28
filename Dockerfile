FROM ubuntu:20.04

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
RUN bash -c "curl -sL \
    https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz \
    | tee >(sudo -u runner tar xzf -) \
    | sha256sum | awk -v expected=$ACTIONS_RUNNER_SHA '{ if (\$1 != expected) { exit 1 } }'"

COPY entrypoint.sh ./
USER runner
CMD ["/bin/sh", "entrypoint.sh"]
