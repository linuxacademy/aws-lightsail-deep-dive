# Remove the default html pages which come pre-installed on the bitnami LAMP instance

cd /opt/bitnami/apache2/htdocs && rm -rf *

# Make sure you are in the bitnami home folder

cd

# Clone the Lightsail Deep Dive course repository to the instance

sudo git clone https://github.com/linuxacademy/aws-lightsail-deep-Dive

# Move into that folder

cd aws-lightsail-deep-Dive


# Move into the application folder

cd ./Scenario3/todo-lamp

# Copy those files into the web server www root folder

cp -R * /opt/bitnami/apache2/htdocs

# Move into the webroot folder

cd /opt/bitnami/apache2/htdocs

# Create configs folder

sudo mkdir /opt/bitnami/apache2/configs

# Set permissions/ownership

sudo chown bitnami:bitnami /opt/bitnami/apache2/configs

# Move the configuration file for the app into this folder

sudo mv /opt/bitnami/apache2/htdocs/config.php /opt/bitnami/apache2/configs

# Set environment variables to prep the application to use the local DB instance

ENDPOINT=localhost && \
USERNAME=root && \
PASSWORD=$(cat /home/bitnami/bitnami_application_password)

# Backup the generic application config file 

cp /opt/bitnami/apache2/configs/config.php /opt/bitnami/apache2/configs/config.php.bak

# Create an application configuration file, substituting in the above environment variables
# Creating a monolithic configuration file in the process.

cat /opt/bitnami/apache2/configs/config.php | \
sed "s/<endpoint>/$ENDPOINT/; \
s/<username>/$USERNAME/; \
s/<password>/$PASSWORD/;" \
>> /opt/bitnami/apache2/configs/config.php.monolithic

# Test this file

cat /opt/bitnami/apache2/configs/config.php.monolithic

# Install this file to be the live app config

cp /opt/bitnami/apache2/configs/config.php.monolithic /opt/bitnami/apache2/configs/config.php

# Do final verification on this file

cat /opt/bitnami/apache2/configs/config.php

