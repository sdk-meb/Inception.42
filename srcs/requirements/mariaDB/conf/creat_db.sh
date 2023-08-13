#! /usr/bin/sh

if [ ! -d /var/lib/mysql/$db_name ]; then

    sed -i "/bind-address/s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
    service mysql start

#   new database creation
#   also new user by it id-pass
#   Grant the newly created user all permissions
#   Create a new user account
#   Grant the new user the same privileges as the existing root user
#   apply the changes
#  quit

 # listen host part specifies the host from which the user is allowed to connect
 # GRANT OPTION part privilege can potentially modify the access rights of other users
 
# listen host part specifies the host from which the user is allowed to connect
    echo  "CREATE DATABASE IF NOT EXISTS $db_name;
            CREATE USER '$db_user_name'@'$listen_host' IDENTIFIED BY '${db_user_passwd}';
            GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user_name'@'$listen_host';
            CREATE USER '$db_admin_name'@'$listen_host' IDENTIFIED BY '$db_admin_passwd';
            GRANT ALL PRIVILEGES ON *.* TO '$db_admin_name'@'$listen_host' IDENTIFIED BY \
            '$db_admin_passwd' WITH GRANT OPTION;
            FLUSH PRIVILEGES;
            FLUSH PRIVILEGES;
            \q
    " | mysql -u root

    mysqladmin -u root password $db_admin_passwd

    sleep 1
    service mysql stop 
fi

exec mysqld $@
