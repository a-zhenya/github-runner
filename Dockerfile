FROM debian:bookworm-slim

LABEL maintainer="Evgeny A" version="1.0"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes curl git sudo gzip ca-certificates software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -M -d / -s /sbin/nologin runner && install -o runner -g runner -d /wrk

WORKDIR /wrk

ENV ACTIONS_RUNNER_VERSION=2.334.0
ENV ACTIONS_RUNNER_SHA=048024cd2c848eb6f14d5646d56c13a4def2ae7ee3ad12122bee960c56f3d271
RUN bash -c "curl -sL \
    https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz \
    | tee >(sudo -u runner tar xzf -) \
    | sha256sum | awk -v expected=$ACTIONS_RUNNER_SHA '{ if (\$1 != expected) { exit 1 } }'"

COPY --chown=runner:runner entrypoint.sh ./
USER runner
CMD ["/bin/sh", "entrypoint.sh"]
