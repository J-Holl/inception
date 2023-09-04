#!/bin/sh

service mysql start;

# -e Execute the statement and quit
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# Reload all privileges from the privilege tables in the mysql database.
mysql -e "FLUSH PRIVILEGES;"
# Stop the server
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

#recommended way to start on Unix (add features like restarting server when errors occurs!!, logs...)
exec mysqld_safe