#!/bin/sh

read -p "Enter Drush Command: " command

echo "drush $command -y mainsite"
drush $command -y

echo "drush $command -y stw24.com"
drush $command -y --uri=stw24.com

echo "drush $command -y tamyah.com"
drush $command -y --uri=tamyah.com

echo "drush $command -y iosot.com"
drush $command -y --uri=iosot.com

echo "drush $command -y 8news.us"
drush $command -y --uri=8news.us
