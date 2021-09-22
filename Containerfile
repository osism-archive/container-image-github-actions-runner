FROM ubuntu:21.04
ARG VERSION=2.282.1

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        buildah \
        ca-certificates \
        curl \
        gcc \
        git \
        gosu \
        jq \
        libc6-dev \
        lsb-release \
        make \
        openssh-client \
        patch \
        podman \
        rsync \
        software-properties-common \
        sudo \
        tini \
        uidmap \
        wget \
        python3-pip \
    && apt-get clean -y \
    && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m github \
    && usermod -aG sudo github \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER github
WORKDIR /home/github
COPY --chown=github:github files/entrypoint.sh ./entrypoint.sh
COPY --chown=github:github files/get_token.py ./get_token.py
COPY --chown=github:github files/requirements.txt ./requirements.txt

RUN python3 -m pip install -r requirements.txt

RUN curl -LO "https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz" \
    && tar xzf ./*.tar.gz \
    && rm ./*.tar.gz

USER root
RUN ./bin/installdependencies.sh

USER github

EXPOSE 443
ENTRYPOINT ["/usr/bin/tini", "--", "/home/github/entrypoint.sh"]
