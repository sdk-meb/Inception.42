#===============================================#

FROM debian:stable

RUN	apt update &&\
    apt upgrade &&\
    apt install nginx --yes 
RUN yes | apt install curl

EXPOSE 443

WORKDIR /etc/nginx

COPY  ./tools/ssl  ssl
COPY  ./conf/  conf.d/
COPY ./tools/nginx.sh tools/


CMD ["sh", "tools/nginx.sh", ""]
