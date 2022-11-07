# syntax=docker/dockerfile:1.4-labs
# ref: https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md

## ref: https://github.com/coder/code-server/blob/main/ci/release-image/Dockerfile
FROM codercom/code-server:latest

USER root

# install docker
RUN curl https://get.docker.com | bash -
RUN usermod -aG docker 'coder'

# start dockerd
RUN mkdir /entrypoint.d
COPY <<EOF /entrypoint.d/dockerd.sh
#!/bin/sh
sudo dockerd &
EOF
RUN chmod +x /entrypoint.d/*

# restore users
USER 1000

RUN mkdir /home/coder/workspaces

# default ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
# ref: https://github.com/coder/code-server/blob/main/ci/release-image/entrypoint.sh
