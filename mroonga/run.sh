#!/bin/bash

MYSQL_EXEC_USER=${MYSQL_EXEC_USER:-mysql}
MYSQL_USER=${MYSQL_USER:-user}
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-asdfg}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-qwerty}

if [ "$1" = 'mysqld' ]; then
  if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Running mysql_install_db ..."
    mysql_install_db --datadir="/var/lib/mysql"
    echo "Finished mysql_install_db"
    
    tempSqlFile='/tmp/mysql-init.sql'
    cat > "$tempSqlFile" <<EOSQL
      DELETE FROM mysql.user;
      CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
      GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
      DROP DATABASE IF EXISTS test ;
EOSQL

    if [ "$MYSQL_USER" -a "$MYSQL_USER_PASSWORD" ]; then
      echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' ;" >> "$tempSqlFile"
      echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%';" >> "$tempSqlFile"
    fi

    echo 'FLUSH PRIVILEGES;' >> "$tempSqlFile"
    set -- "$@" --init-file="$tempSqlFile"
  fi
  chown -R mysql:mysql /var/lib/mysql

  echo "Installing mroonga ..."
  mysqld --user=$MYSQL_EXEC_USER &
  sleep 5
  mysql -u root < /usr/share/mroonga/install.sql
  ps aux | grep "mysqld" | grep -v grep | awk '{ print $2  }' | xargs kill -KILL
  echo "Finished installing mroonga"
  set -- "$@" --user=$MYSQL_EXEC_USER
fi

exec "$@"
