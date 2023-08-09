#=======================================================================#
# Docker image made-up by debian as base and pkgs of WordPress + php-fpm
#           server:
#               - { wordpress } official platform
#               - { php-fpm } helpful /
#=====================================================================#

# deb-OS as base 
FROM debian:buster

# base floor
RUN	apt update &&\
    apt upgrade

RUN apt install --yes \
        curl mariadb-server \
        php7.3 php7.3-cgi \
        php7.3-fpm php7.3-mysql php7.3-gd php7.3-curl \
        php7.3-xml php7.3-mbstring php7.3-zip php7.3-pdo \
        php7.3-cli 

RUN curl -LOk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod o+x wp-cli.phar && \
    ln wp-cli.phar /usr/local/bin/wp

COPY ./conf/wp-config-creat.sh /tmp/wp.sh


EXPOSE 9000

ENTRYPOINT ["sh", "/tmp/wp.sh"]

# Start Wordpress-PHP service
CMD [ "/usr/sbin/php-fpm7.3", "-F"]
