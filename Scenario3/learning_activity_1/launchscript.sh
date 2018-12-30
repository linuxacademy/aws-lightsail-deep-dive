#! /bin/bash
sudo /opt/bitnami/ctlscript.sh stop apache
sudo mv /opt/bitnami/apache2/scripts/ctl.sh /opt/bitnami/apache2/scripts/ctl.sh.disabled

cd /home/bitnami
sudo git clone https://github.com/linuxacademy/aws-lightsail-deep-dive/Scenario3/todo-mean
cd /home/bitnami/todo-mean
sudo npm install --production

sudo cat << EOF >> /home/bitnami/todo-mean/.env
PORT=80
DB_URL=mongodb://tasks:tasks@localhost:27017/?authMechanism=SCRAM-SHA-1&authSource=tasks
EOF
