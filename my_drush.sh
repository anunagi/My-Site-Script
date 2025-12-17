#!/bin/bash

# Check if command is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

CMD="$@"

# 1. Run on Default/Main site (no URI)
echo "========================================"
echo "Processing Main Site (default)"
echo "Executing: drush $CMD -y"
drush $CMD -y

# 2. Run on all other sites
SITES_DIR="/opt/bitnami/drupal/sites"

for site_dir in "$SITES_DIR"/*; do
    if [ -d "$site_dir" ]; then
        site_name=$(basename "$site_dir")

        # Skip default (already handled) and non-site dirs if any (like 'all')
        if [ "$site_name" == "default" ] || [ "$site_name" == "." ] || [ "$site_name" == ".." ]; then
            continue
        fi
        
        # Check if settings.php exists to be sure it is a site
        if [ -f "$site_dir/settings.php" ]; then
             echo "----------------------------------------"
             echo "Processing site: $site_name"
             echo "Executing: drush $CMD -y --uri=$site_name"
             drush $CMD -y --uri="$site_name"
        fi
    fi
done
