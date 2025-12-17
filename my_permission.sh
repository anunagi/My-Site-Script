#!/bin/bash

# Put this script to /opt/bitnami/drupal/sites

if [ -z "$1" ]; then
  echo "Usage: $0 <site_name|all>"
  exit 1
fi

TARGET="$1"
SITES_DIR="/opt/bitnami/drupal/sites"

# Function to set permissions
set_permissions() {
    local site_name="$1"
    local site_path="$SITES_DIR/$site_name"

    if [ ! -d "$site_path" ]; then
        echo "Warning: Directory $site_path not found."
        return
    fi

    echo "----------------------------------------"
    echo "Processing site: $site_name"

    if [ -f "$site_path/settings.php" ]; then
        echo "chmod 644 $site_path/settings.php"
        chmod 644 "$site_path/settings.php"
    else
        echo "Skipping settings.php (not found)"
    fi

    if [ -f "$site_path/services.yml" ]; then
        echo "chmod 644 $site_path/services.yml"
        chmod 644 "$site_path/services.yml"
    fi

    echo "chmod 775 $site_path"
    chmod 775 "$site_path"
}

if [ "$TARGET" == "all" ]; then
    # Loop through all directories
    for site_dir in "$SITES_DIR"/*; do
        if [ -d "$site_dir" ]; then
            site_name=$(basename "$site_dir")
            # Skip . and .. and potentially not directories handled by glob expansion
            if [ "$site_name" == "." ] || [ "$site_name" == ".." ]; then
                continue
            fi
            
            set_permissions "$site_name"
        fi
    done
else
    # Process single site
    set_permissions "$TARGET"
fi

echo "All done!"
exit 0
