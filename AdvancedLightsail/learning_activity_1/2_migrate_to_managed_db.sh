# Set an environment variable with the DNS endpoint of the managed
LS_ENDPOINT = 'DNSENDPOINTOFDB' # (set this to your DB's DNS name, replace DNSENDPOINTOFDB)
# Set authentication variables
LS_USERNAME=dbmasteruser
LS_PASSWORD=taskstasks
# Create a Managed DB config file
cat /opt/bitnami/apache2/configs/config.php.bak | \
    sed "s/<endpoint>/$LS_ENDPOINT/; \
    s/<username>/$LS_USERNAME/; \
    s/<password>/$LS_PASSWORD/;" \
    >> /opt/bitnami/apache2/configs/config.php.lightsail_db
# Confirm its been created 
cat /opt/bitnami/apache2/configs/config.php.lightsail_db
# Make this config file the live application config
cp /opt/bitnami/apache2/configs/config.php.lightsail_db /opt/bitnami/apache2/configs/config.php
# Migrate data from the on-instance DB to the managed DB
mysqldump -u root \
--databases tasks \
--single-transaction \
--compress \
--order-by-primary  \
-p$(cat /home/bitnami/bitnami_application_password) \
| mysql -u $LS_USERNAME \
--port=3306 \
--host=$LS_ENDPOINT \
-p$LS_PASSWORD 

