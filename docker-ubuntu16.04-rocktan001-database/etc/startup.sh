#! /bin/bash
set -e

ROOT_PWD=${ROOT_PWD:-"F96AEB124C"}
ROCK_USER_PWD=${ROCK_USER_PWD:-"F96AEB124C"}

MYSQL_ROOT_PWD=${MYSQL_ROOT_PWD:-"F96AEB124C"}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_USER_PWD=${MYSQL_USER_PWD:-""}
MYSQL_USER_DB=${MYSQL_USER_DB:-""}


if [ -n "$ROOT_PWD" ]; then
	echo "[i] Reset  Root Password: $ROOT_PWD"
	echo "root:${ROOT_PWD}" | chpasswd

fi

if [ -n "$ROCK_USER_PWD" ]; then
	echo "[i] Reset  rock Password: $ROCK_USER_PWD"
	echo "rock:${ROCK_USER_PWD}" | chpasswd

fi

echo "[i] Setting up new power user credentials."


mysqld_safe --skip-grant-tables --skip-networking &  sleep 5



if [ -n "$MYSQL_ROOT_PWD" ]; then
    echo "[i] Setting MYSQL root new password : ${MYSQL_ROOT_PWD}"
    mysql -e "UPDATE mysql.user set authentication_string=password('$MYSQL_ROOT_PWD') where user='root'; FLUSH PRIVILEGES;"
    mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi

if [ -n "$MYSQL_USER_DB" ]; then
    echo "[i] Creating datebase: $MYSQL_USER_DB"
    mysql --user=root --password=$MYSQL_ROOT_PWD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_USER_DB\` CHARACTER SET utf8 COLLATE utf8_general_ci; FLUSH PRIVILEGES;"

    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_USER_PWD" ]; then
        echo "[i] Create new User: $MYSQL_USER with password $MYSQL_USER_PWD for new database $MYSQL_USER_DB."
        mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON \`$MYSQL_USER_DB\`.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    else
        echo "[i] Don\`t need to create new User."
    fi
else
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_USER_PWD" ]; then
        echo "[i] Create new User: $MYSQL_USER with password $MYSQL_USER_PWD for all database."
        mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    else
        echo "[i] Don\`t need to create new User."
    fi
fi

killall mysqld
sleep 5

echo "[i] Setting end,have fun."

exec "$@"