#===================================================================#
# Docker image building that contains NGINX with TLSv1.2 or TLSv1.3
#        server:  { web-server } required
#===============================================================#

# deb-OS as base 
FROM debian:stable

# base floor
RUN	apt update &&\
    apt upgrade

RUN apt install -y nginx tini

# WORKDIR /etc/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./tools/ssl /etc/nginx

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["nginx", "-g", "daemon off;"]
