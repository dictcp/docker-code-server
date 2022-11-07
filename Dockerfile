#syntax=docker/dockerfile:1.4-labs

FROM codercom/code-server:latest

USER root

# setup docker
RUN curl https://get.docker.com | bash -
RUN sudo usermod -aG docker 'coder'

RUN mkdir /entrypoint.d

COPY <<EOF /entrypoint.d/dockerd.sh
#!/bin/sh
sudo dockerd &
EOF

RUN chmod +x /entrypoint.d/*

USER 1000
