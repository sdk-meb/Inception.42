#! DOCKER_FILE

# ARGS
ARG	VERSION=latest

# instruction _FROM_ / 
    # which Parent image will build from it
FROM debian:$VERSION

# instruction _RUN_ /
    # RUN COMMAND/S and commit it inside image's
RUN apt update && \
    apt install mariadb --yes


CMD /bin/sh

