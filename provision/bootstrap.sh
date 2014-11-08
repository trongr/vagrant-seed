#!/usr/bin/env bash

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
echo "TODO. copying nginx configs"
# cp configs/nginx/conf.d/* /etc/nginx/conf.d/
echo "restarting nginx server"
service nginx restart

# TODO. uncomment. don't actually need mysql, just wanted to try out debconfutils
echo "debconf utils configuring mysql server password"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASS"
echo "installing mysql client mysql server"
apt-get install -y mysql-server mysql-client
echo "creating database and granting privileges"
mysql -u root -p $DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -u root -p $DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASS'"
echo "restarting mysql server"
service mysql restart
