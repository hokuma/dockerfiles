#!/bin/bash

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-rootpassword}
MYSQL_USER=${MYSQL_USER:-user}
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-password}

if [ "$1" = "/usr/sbin/mysqld" ]; then
  if [ ! -e "/var/lib/mysql/data" ]; then
    echo "mysql_install_db..."
    mysql_install_db
    chown -R mysql:mysql /var/lib/mysql
    echo "done"

    echo "Set up mysqld..."
    /usr/sbin/mysqld --user=mysql &
    mysql_pid=$!
    sleep 5
    mysql -u root < /usr/share/mroonga/install.sql
    /usr/bin/mysqladmin password $MYSQL_ROOT_PASSWORD -u root
    kill $mysql_pid
    sleep 3
    echo "done"

    echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' ;" >> /tmp/mysql-init.sql
    echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%';" >> /tmp/mysql-init.sql

    set "$@" --user=mysql --init-file=/tmp/mysql-init.sql
  fi
fi

exec "$@"
