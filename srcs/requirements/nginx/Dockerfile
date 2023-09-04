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
# 2. Install NGINX
# 3. Install OpenSSL for self-signed certificate
RUN apt-get update && apt-get install -y \
	nginx \
	openssl

# Directory for certificate & key
RUN mkdir -p /etc/ssl

# Generate certificate & key
# The req command primarily creates and processes certificate requests in PKCS#10 format.
# It can additionally create self signed certificates for use as root CAs for example.
# -newkey rsa:4096 create a new certificate and a new private key RSA 4096bits size.
# -x509 outputs a self signed certificate 
# -days this specifies the number of days to certify the certificate for
# -nodes not encrypt private key - allows us to avoid prompt
# -subj input relevant information according records on domain nane - 
# here allows us to avoid prompt
# -out where we put certificate
# -keyout where we put key

RUN openssl req -newkey rsa:4096 -x509 -days 666 -nodes \
-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jholl.42.fr/UID=jholl" \
-out /etc/ssl/certs/inception.crt \
-keyout /etc/ssl/private/inception.key

# COPY [--chown=<user>:<group>] <src>... <dest>
# The COPY instruction copies new files or directories from <src> and adds 
# them to the filesystem of the container at the path <dest>.

# We recuperate our nginx.conf in our docker
COPY conf/nginx.conf /etc/nginx/nginx.conf

#Use chmod to give the right to the user to edit html folder 
#(www-data is user used by nhinx and php)
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# CMD ["executable","param1","param2"]
# The main purpose of a CMD is to provide defaults for an executing container.
# -g sets a global configuration option then alows us to deamon off and put
# ngninx in foreground 
CMD [ "nginx", "-g", "daemon off;" ]
