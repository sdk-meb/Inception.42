#! /usr/bin/sh


sed -i "/bind-address/s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

if [ false ]; then
    service mysql start
    mysql -e "CREATE DATABASE IF NOT EXISTS ${database_name};"
    mysql -e "CREATE USER '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';"
    mysql -u${mysql_root_user} -p${mysql_root_password} -e "ALTER USER '${mysql_root_user}'@'localhost' IDENTIFIED BY '${mysql_root_password}';"
    mysql -e "FLUSH PRIVILEGES;"
    mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown
else
if [ ! -d /var/lib/mysql/$WP_DB_NAME ]; then
    service mysql start 
    mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"
    mysql -u root -e "CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASS';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';"
    mysql -u root -e "CREATE USER '$MDB_ROOT_USER'@'%' IDENTIFIED BY '$MDB_ROOT_PASS';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MDB_ROOT_USER'@'%' WITH GRANT OPTION;"
    mysql -u root -e "FLUSH PRIVILEGES;"
    mysqladmin -u root password $MDB_ROOT_PASS
    service mysql stop
fi
fi
