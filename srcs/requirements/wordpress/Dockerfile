#! DOCKER_FILE

ARG	VERSION=latest

FROM debian:$VERSION

RUN apt update && \
    apt install wordpress --yes

CMD /bin/sh

