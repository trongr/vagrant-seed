#!/usr/bin/env bash

ROOTDIR=/home/vagrant/nt
CONFGITHUB=https://github.com/trongtruong/conf.git

DBNAME=testdb
DBUSER=testuser
DBPASS=testpass

echo "PROVISIONING VM"
echo "INSTALLING PACKAGES"

apt-get update

echo "INSTALLING DEBCONF-UTILS"
apt-get install -y debconf-utils

echo "INSTALLING GIT"
apt-get install -y git

echo "INSTALLING NGINX"
apt-get install -y nginx
cp $ROOTDIR/provision/nginx/sites-enabled/default /etc/nginx/sites-enabled/
echo "RESTARTING NGINX SERVER"
service nginx restart

# # don't actually need mysql, just wanted to try out debconfutils
# echo "DEBCONF UTILS CONFIGURING MYSQL SERVER PASSWORD"
# debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASS"
# debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASS"
# echo "INSTALLING MYSQL CLIENT MYSQL SERVER"
# apt-get install -y mysql-server mysql-client
# echo "CREATING DATABASE AND GRANTING PRIVILEGES"
# # NOTE -uroot -p$DBPASS and not -u root -p $DBPASS
# mysql -uroot -p$DBPASS -e "CREATE DATABASE $DBNAME"
# mysql -uroot -p$DBPASS -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASS'"
# echo "RESTARTING MYSQL SERVER"
# service mysql restart

echo "INSTALLING NODE"
apt-get install -y python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

echo "INSTALLING MONGODB"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install -y mongodb-org
service mongod restart
