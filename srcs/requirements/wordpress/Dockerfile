#=======================================================================#
# Docker image made-up by debian as base and pkgs of WordPress + php-fpm
#           server:
#               - { wordpress } official platform
#               - { php-fpm } helpful /
#=====================================================================#

# debian as floor base
FROM floor:latest

RUN apt install --yes \
        curl mariadb-server

RUN curl -LOk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod o+x wp-cli.phar && \
        ln wp-cli.phar /usr/local/bin/wp

RUN  apt install --yes \
        php7.4 php7.4-cgi \
        php7.4-fpm php7.4-mysql php7.4-gd php7.4-curl \
        php7.4-xml php7.4-mbstring php7.4-zip php7.4-pdo \
        php7.4-cli 

EXPOSE 9000

COPY ./conf/wp-config-creat.sh /tmp/wp.sh
RUN chmod 777 /tmp/wp.sh


ENTRYPOINT ["sh", "/tmp/wp.sh"]

# Start Wordpress-PHP service
CMD [ "/usr/sbin/php-fpm7.4", "-F"]
