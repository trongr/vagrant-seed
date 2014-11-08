#!/usr/bin/env bash

ROOTDIR=/home/vagrant/nt
CONFGITHUB=https://github.com/trongtruong/conf.git

DBNAME=testdb
DBUSER=testuser
DBPASS=testpass

echo "provisioning vm"
echo "installing packages"

apt-get -y update

echo "installing debconf-utils"
apt-get install -y debconf-utils

echo "installing git"
apt-get install -y git

echo "installing nginx"
apt-get install -y nginx
cp $ROOTDIR/provision/nginx/sites-enabled/default /etc/nginx/sites-enabled/
echo "restarting nginx server"
service nginx restart

# # don't actually need mysql, just wanted to try out debconfutils
# echo "debconf utils configuring mysql server password"
# debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASS"
# debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASS"
# echo "installing mysql client mysql server"
# apt-get install -y mysql-server mysql-client
# echo "creating database and granting privileges"
# # NOTE -uroot -p$DBPASS and not -u root -p $DBPASS
# mysql -uroot -p$DBPASS -e "CREATE DATABASE $DBNAME"
# mysql -uroot -p$DBPASS -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASS'"
# echo "restarting mysql server"
# service mysql restart
