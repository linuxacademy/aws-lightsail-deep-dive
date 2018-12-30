#!/bin/bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

sudo cat /etc/mongod.conf | sed "s/\b127.0.0.1\b/&,$(hostname -i)/" >> /etc/mongod.conf.new

sudo mv /etc/mongod.conf /etc/mongd.conf.old
sudo mv /etc/mongod.conf.new /etc/mongod.conf

sudo service mongod start
