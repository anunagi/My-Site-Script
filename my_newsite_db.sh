#!/bin/sh

# Put this script to /opt/bitnami/drupal/sites

read -p "Enter New Site: " site

echo "mkdir $site"
mkdir $site

echo "chmod 777 $site"
chmod 777 $site

echo "mkdir $site/files"
mkdir $site/files

echo "chmod 777 $site/files"
chmod 777 $site/files

echo "cp default/default.services.yml $site/services.yml"
cp default/default.services.yml $site/services.yml

echo "chmod 777 $site/services.yml"
chmod 777 $site/services.yml

echo "cp default/default.settings.php $site/settings.php"
cp default/default.settings.php $site/settings.php

echo "chmod 777 $site/settings.php"
chmod 777 $site/settings.php

#get the database name
read -p "Enter database name: " dbname
read -p "Enter database user: " dbuser
read -p "Enter database user password: " dbuserpass
mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE $dbname;
create user '$dbuser'@'127.0.0.1' identified by '$dbuserpass';
grant all privileges on $dbname.* TO '$dbuser'@'127.0.0.1';
flush privileges;
MYSQL_SCRIPT

echo "All done!"
exit 0
