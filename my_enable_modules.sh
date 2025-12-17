#!/bin/bash

# Check if at least one module name is provided
if [ -z "$1" ]; then
  echo "Error: No module names provided."
  echo "Usage: $0 <module1> [module2] [module3] ..."
  exit 1
fi

# Store all arguments for display purposes
MODULES="$@"
DRUPAL_ROOT="/opt/bitnami/drupal"

# Navigate to Drupal root
cd "$DRUPAL_ROOT" || exit

echo "Starting to enable modules: $MODULES on all sites..."

# Loop through all directories in sites/
# Exclude '.', '..', 'default', and standard files
for site_dir in sites/*; do
  if [ -d "$site_dir" ]; then
    site=$(basename "$site_dir")
    
    # Skip 'default' folder and any common non-site folders if necessary
    if [ "$site" == "default" ] || [ "$site" == "all" ]; then
      continue
    fi

    echo "--------------------------------------------------"
    echo "Processing site: $site"
    
    # Run drush enable with all provided arguments
    # "$@" expands to "$1" "$2" "$3" ... preserving separate arguments
    vendor/bin/drush --uri="$site" pm:enable "$@" -y
    
    if [ $? -eq 0 ]; then
        echo "Successfully processed modules on $site"
    else
        echo "Failed to process modules on $site"
    fi
  fi
done

echo "--------------------------------------------------"
echo "Operation completed."
