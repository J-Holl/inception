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
# 2. Install MARIADB
RUN apt-get update && apt-get install -y \
	mariadb-server 

# COPY [--chown=<user>:<group>] <src>... <dest>
# The COPY instruction copies new files or directories from <src> and adds 
# them to the filesystem of the container at the path <dest>.

# We recuperate our mariadb.conf in our docker
COPY conf/mariadb.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the bash script to create the database and the user into the container
COPY conf/config.sh /config.sh

# How the container will run - cannot be override in docker run - imply this container
# is specifically built for this use
ENTRYPOINT ["bash", "config.sh"]

# Expose the port allowed by the subject to commuicate with wordpress (MySQL)
EXPOSE 3306