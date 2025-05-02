#!/bin/sh

read -p "Enter Drush Command: " command

echo "drush $command -y mainsite"
drush $command -y

echo "drush $command -y 4pdecor.com"
drush $command -y --uri=4pdecor.com

echo "drush $command -y bpcarservice.com"
drush $command -y --uri=bpcarservice.com

echo "drush $command -y xn--n3cfac0ercx4b8kvc.com"
drush $command -y --uri=xn--n3cfac0ercx4b8kvc.com
