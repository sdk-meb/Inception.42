#! /usr/bin/bash

if [ ! -d /run/php ]; then
    mkdir -p /run/php
    chmod 777 /run/php
fi

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -e /var/www/wordpress/wp-config.php ]; then
    # 
    mkdir -p /var/www/wordpress
    chmod -R 775 /var/www/wordpress
    cd /var/www/wordpress

    # 
    wp core download --allow-root \
        --locale=en_US \
        --version=6.1.1

    sleep 3 # waiting for databse configuration
    # Command that creates a wp-config.php file
    wp config create --allow-root \
        --dbhost="$WP_DB_HOST" \
        --dbname="$WP_DB_NAME" \
        --dbuser="$WP_DB_USER" \
        --dbpass="$WP_DB_PASS" \
        --dbprefix=wp_

    # Command which installs WordPress while creating an admin for it
    wp core install --allow-root \
        --title='My Modest Blog' \
        --url="$DOMAIN_NAME" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    # Command that creates a user
    wp user create --allow-root \
        "$WP_USER_NAME" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASS" \
        --role=author

    # 
    wp theme install twentytwentytwo --activate --allow-root

    chown -R www-data:www-data /var/www/wordpress
fi

exec "$@"
