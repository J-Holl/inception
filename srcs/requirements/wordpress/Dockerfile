# FROM instruction initializes a new build stage and sets the Base Image
# for subsequent instructions
# Alpine or debian?
# Alpine Linux is a security-oriented, lightweight Linux distribution 
# Debian is massively supported, stable, reliable... Reason I choose Debian is 
# this is the most used base image. 
FROM debian:buster

# RUN <command> (shell form, the command is run in a shell, which by default is /bin/sh -c
# The RUN instruction will execute any commands in a new layer on top of
# the current image and commit the results. 
# The resulting committed image will be used for the next step in the Dockerfile
# MAJ of apt-get, to get the last version of packages

# 1. Update and install in the same line ensures your Dockerfile installs 
# the latest package versions with no further coding or manual intervention.
# This technique is known as “cache busting".
# Official Debian and Ubuntu images automatically run apt-get clean,
# so explicit invocation is not required.
# 2. Install wget, php and mariadb
RUN apt-get update && apt-get install -y \
	wget \
	php7.3 \
 	php-fpm\
	php-mysql\
	mariadb-client 

# We downald wordpress version 6.0 (last branch but not last version) with wget
# we put it in /var/www , extract it and then delete the archive
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

# COPY [--chown=<user>:<group>] <src>... <dest>
# The COPY instruction copies new files or directories from <src> and adds 
# them to the filesystem of the container at the path <dest>.

# We recuperate our wordrpress.conf and our script in our docker
COPY	./conf/php.conf			/etc/php/7.3/fpm/pool.d/www.conf
COPY	conf/config.sh config.sh	

# We get right for our wordpress dir 
RUN		chown -R root:root /var/www/wordpress

# We downlad wp-cli to auto-configure wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# We get right for write our wp-cli dir
# We put it in the right place
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["bash", "config.sh"]
