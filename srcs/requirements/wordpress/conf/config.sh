#!bin/bash
sleep 10
#wp config
#Creates a new wp-config.php with database constants,
#and verifies that the database constants are correct.
#1. set the database name
#2. set the database user
#3. set the pass for the user
#4. set the database host with --path param to locate it

if [ ! -e /var/www/wordpress/wp-config.php ]; then
    wp config create	--allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
    					--dbhost=mariadb:3306 --path='/var/www/wordpress'

sleep 2
#wp core install
# Creates the WordPress tables in the database using the URL, title, 
# and default admin user details provided. 
# Performs the famous 5 minute install in seconds or less.
# --allow-root run wp-cli as root
wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
#wp user create
# Create a new user...
# --role The role of the user to create. Default: default role. 
# Possible values include ‘administrator’, ‘editor’, ‘author’, ‘contributor’, ‘subscriber’. 
wp user create      --allow-root --role=author $JHOLL_LOGIN $JHOLL_MAIL --user_pass=$JHOLL_PASS --path='/var/www/wordpress' 
fi

# create a forlder for php
mkdir -p ./run/php

#start php-fpm and -F force to stay in foreground 
/usr/sbin/php-fpm7.3 -F
