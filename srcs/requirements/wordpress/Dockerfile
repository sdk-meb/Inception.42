#=======================================================================#
# Docker image made-up by debian as base and pkgs of WordPress + php-fpm
#           server:
#               - { wordpress } official platform
#               - { php-fpm } helpful /
#=====================================================================#

# debian as floor base
FROM floor:latest

RUN apt install --yes curl  mariadb-client \
        php7.4 php7.4-cgi \
        php7.4-fpm php7.4-mysql php7.4-gd php7.4-curl \
        php7.4-xml php7.4-mbstring php7.4-zip php7.4-pdo \
        php7.4-cli 

# WP-cli tool for interacting with and managing wp-sites   
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
        chmod o+x wp-cli.phar &&\
        ln wp-cli.phar /usr/local/bin/wp &&\
        mkdir --mode=775 -p  /var/www/wordpress

WORKDIR  /var/www/wordpress

RUN wp core download --allow-root \
        --context=. \
        --version=6.3 

EXPOSE 9000

COPY ./conf/wp-config-creat.sh /sbin/wp

# config script as enterpoint 
ENTRYPOINT ["bash", "/sbin/wp"]

CMD [ "/usr/sbin/php-fpm7.4", "-F"]
