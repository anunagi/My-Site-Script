#!/bin/sh

# Put this script to /opt/bitnami/drupal/sites

read -p "Enter Site: " site

echo "chmod 644 $site/settings.php"
chmod 644 $site/settings.php

echo "chmod 644 $site/services.yml"
chmod 644 $site/services.yml

echo "chmod 775 $site"
chmod 775 $site

echo "All done!"
exit 0
