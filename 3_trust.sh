#!/bin/sh

read -p "Enter site: " site
read -p "Enter extension: " extension
echo "
"$"settings['trusted_host_patterns'] = array(
'^www\.$site\.$extension$',
'^$site\.$extension$',
);" >> /opt/bitnami/drupal/sites/$site.$extension/settings.php

