#! /usr/bin/bash

mkdir -p --mode=777 /run/php
if [ ! -e /run/php/php7.4-fpm.pid ]; then
    touch /run/php/php7.4-fpm.pid
fi

if [ ! -e /var/www/wordpress/wp-config.php ]; then

# allow running the WP-CLI commands with the root user
rootable=--allow-root

#
    sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/7.4/fpm/pool.d/www.conf

#__ Download and install WordPress

# Download 6.3 version of WordPress
    wp core download $rootable \
        --context=. \
        --version=6.3 

# waiting for databse configuration
    # sleep 3 #  no--skip-ckeck 

# Create a new wp-config.php file
    wp config create $rootable \
        --dbname="$db_name" \
        --dbuser="$db_user_name" \
        --dbpass="$db_user_passwd" \
        --dbhost="$db_host"


# Install WordPress 
    wp core install $rootable \
        --url=$DOMAIN_NAME \
        --title=$titel \
        --admin_user=$admin_name \
        --admin_password=$admin_passwd \
        --admin_email=$admin_mail \
        --skip-email

    wp theme install $theme  $rootable --activate 

# Add a user as a super-admin
    # is not multiset installation 
    # wp super-admin add $admin_name $rootable

# Command that creates a user

    wp user create $rootable \
        $wp_user_name $wp_user_mail --role=$role \
        --user_pass=$wp_user_passwd
fi

exec $@
