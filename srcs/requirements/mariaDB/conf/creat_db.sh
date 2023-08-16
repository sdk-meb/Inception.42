#! /usr/bin/sh

if [ ! -d /var/lib/mysql/$db_name ]; then

    sed -i "/bind-address/s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
    service mariadb start

#   new database creation
#   also new user by it id-pass
#   Grant the newly created user all permissions
#   apply the changes
#  quit

 # listen host part specifies the host from which the user is allowed to connect
 # GRANT OPTION part privilege can potentially modify the access rights of other users
 
# listen host part specifies the host from which the user is allowed to connect
    echo  "CREATE DATABASE IF NOT EXISTS $db_name;
            CREATE USER '$db_user_name'@'$listen_host' IDENTIFIED BY '${db_user_passwd}';
            GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user_name'@'$listen_host';
            FLUSH PRIVILEGES;
            \q
    " | mysql -u root

# set root password 
    mysql -u root -e "ALTER USER '$DB_root_name'@'localhost'\
                        IDENTIFIED BY '$DB_root_passwd';" 

    sleep 1
    service mariadb stop 

fi

exec mysqld
