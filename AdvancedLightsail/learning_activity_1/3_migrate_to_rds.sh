# make sure RDS instance is created and full ready before continuing
# make sure peering is enabled before continuing.

# Set an environment variable with the DNS endpoint of the managed
LS_ENDPOINT = 'DNSENDPOINTOFDB' # (set this to your DB's DNS name, replace DNSENDPOINTOFDB)
# Set authentication variables
LS_USERNAME=dbmasteruser
LS_PASSWORD=taskstasks

# Set an environment variable with the DNS endpoint of the managed
RDS_ENDPOINT = 'RDSDNSNAME' # (set this to your DB's DNS name, replace RDSDNSNAME)
# Set authentication variables
RDS_USERNAME=RDSUSERNAME
RDS_PASSWORD=RDSPASSWORD

# Create a Managed DB config file
cat /opt/bitnami/apache2/configs/config.php.bak | \
    sed "s/<endpoint>/$RDS_ENDPOINT/; \
    s/<username>/$RDS_USERNAME/; \
    s/<password>/$RDS_PASSWORD/;" \
    >> /opt/bitnami/apache2/configs/config.php.lightsail_rds_db
# Confirm its been created 
cat /opt/bitnami/apache2/configs/config.php.lightsail_rds_db
# Make this config file the live application config
cp /opt/bitnami/apache2/configs/config.php.lightsail_rds_db /opt/bitnami/apache2/configs/config.php

# Set the environment variable for the 
# Migrate data from the on-instance DB to the managed DB
mysqldump -u $LS_USERNAME \
--databases tasks \
--single-transaction \
--compress \
--order-by-primary  \
--host=$LS_ENDPOINT
-p$LS_PASSWORD \
| mysql -u $RDS_USERNAME \
--port=3306 \
--host=$RDS_ENDPOINT \
-p$RDS_PASSWORD 

