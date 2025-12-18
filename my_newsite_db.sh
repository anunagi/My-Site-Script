#!/bin/sh

# Put this script to /opt/bitnami/drupal/sites
# Run it like: ./sites/my_newsite_db.sh <site> <dbname> <dbuser> <dbpass>.

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <site_name> <db_name> <db_user> <db_password>"
    exit 1
fi

site=$1
dbname=$2
dbuser=$3
dbuserpass=$4

echo "Creating site directory: $site"
mkdir -p "$site"
chmod 777 "$site"

echo "Creating files directory"
mkdir -p "$site/files"
chmod 777 "$site/files"

echo "Copying services.yml"
cp default/default.services.yml "$site/services.yml"
chmod 777 "$site/services.yml"

echo "Copying settings.php"
cp default/default.settings.php "$site/settings.php"
chmod 777 "$site/settings.php"

echo "Setting up database '$dbname' for user '$dbuser'"
mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $dbname;
CREATE USER IF NOT EXISTS '$dbuser'@'127.0.0.1' IDENTIFIED BY '$dbuserpass';
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'127.0.0.1';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "All done!"
exit 0
