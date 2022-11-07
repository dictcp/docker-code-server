#syntax=docker/dockerfile:1.4-labs

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
