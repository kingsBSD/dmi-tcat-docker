#!/bin/bash
dead=1
while [ "$(($dead))" -gt 0 ]
do
dead=`(mysql -h"db" -P"3306" -u root -p"$MYSQL_ROOT_PASSWORD" -e "select 1" || echo down) | grep -c down`
echo "Waiting for the database..."
done
mysql -h"db" -P"3306" -u root -p"$MYSQL_ROOT_PASSWORD" < /tcat_db.sql
echo "Created the database."
