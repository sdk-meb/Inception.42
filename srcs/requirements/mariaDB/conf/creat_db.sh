#! /usr/bin/sh

if [ ! -d /var/lib/mysql/$db_name ]; then

    sed -i "/bind-address/s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
    service mysql start

#   new database creation
    mysql -u root --execute="CREATE DATABASE IF NOT EXISTS $db_name;"

#   also new user by it id-pass
    # listen host part specifies the host from which the user is allowed to connect
    mysql -u root -e "CREATE USER '$db_user_name'@'$listen_host' IDENTIFIED BY '${db_user_passwd}';"

# Grant the newly created user all permissions
    mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user_name'@'$listen_host';"

# Create a new user account
    mysql -u root -e "CREATE USER '$db_admin_name'@'$listen_host' IDENTIFIED BY '$db_admin_passwd';"

# Grant the new user the same privileges as the existing root user
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$db_admin_name'@'$listen_host' WITH GRANT OPTION;"
                        #IDENTIFIED BY '$db_admin_passwd'\

#  apply the changes
    mysql -u root -e "FLUSH PRIVILEGES;"

    mysqladmin -u root password $db_admin_passwd
    service mysql stop
fi

exec $@

#     mysql -u${mysql_root_user} -p${mysql_root_password} -e "...;"
#     mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown
