#! DOCKER_FILE

ARG	VERSION=latest

FROM debian:$VERSION

RUN apt update && \
    apt install mariadb-server --yes


CMD /bin/sh -c mysql_secure_installation

