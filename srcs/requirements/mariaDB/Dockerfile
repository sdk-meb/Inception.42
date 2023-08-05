#===============================================#

FROM debian:stable

RUN	apt update &&\
    apt upgrade &&\
    yes | apt install mariadb mariadb-client

EXPOSE 44

CMD ["sh", "tools/nginx.sh", ""]
