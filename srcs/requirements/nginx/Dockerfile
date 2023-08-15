#===================================================================#
# Docker image building that contains NGINX with TLSv1.2 or TLSv1.3
#        server:  { web-server } required
#===============================================================#

# deb-OS as base 
FROM floor:latest

RUN apt install -y nginx tini 

COPY ./tools/ssl /etc/nginx/ssl
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf


ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["nginx", "-g", "daemon off;"]
