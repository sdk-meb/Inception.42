#===================================================================#
# Docker image building that contains NGINX with TLSv1.2 or TLSv1.3
#        server:  { web-server } required
#===============================================================#

# deb-OS as base 
FROM floor:latest

RUN apt install -y nginx tini  
#openssl

# RUN mkdir -p /etc/nginx/ssl/ && \
#     openssl req -x509 -sha256 -days 356 -nodes \
#         -newkey rsa:2048 \
#         -subj "/C=MA/ST=KBN/O=42-Network/CN=mes-sadk.42.fr" \
#         -keyout /etc/nginx/ssl/mes-sadk.42.fr.key \
#         -out /etc/nginx/ssl/mes-sadk.42.fr.crt
# WORKDIR /etc/nginx
EXPOSE 443

COPY ./tools/ssl /etc/nginx/ssl
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf


ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["nginx", "-g", "daemon off;"]
