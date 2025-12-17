#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <site_domain|all>"
    exit 1
fi

TARGET="$1"
SITES_DIR="/opt/bitnami/drupal/sites"

add_trusted_host() {
    local domain="$1"
    local site_path="$SITES_DIR/$domain"
    local settings_file="$site_path/settings.php"

    if [ ! -d "$site_path" ]; then
         echo "Directory $domain not found."
         return
    fi
    
    if [ ! -f "$settings_file" ]; then
        echo "settings.php not found for $domain"
        return
    fi

    # Escape dots for regex
    # bash substitution: ${var//./\\.}
    local escaped_domain="${domain//./\\.}"

    echo "Adding trusted_host_patterns to $domain"
    
    cat <<EOF >> "$settings_file"

\$settings['trusted_host_patterns'] = array(
  '^www\.$escaped_domain$',
  '^$escaped_domain$',
);
EOF

}

if [ "$TARGET" == "all" ]; then
    for site_dir in "$SITES_DIR"/*; do
        if [ -d "$site_dir" ]; then
            site_name=$(basename "$site_dir")
            # Skip default, ., ..
            if [ "$site_name" == "default" ] || [ "$site_name" == "." ] || [ "$site_name" == ".." ]; then
                continue
            fi
            
            # Check if settings.php exists specifically
            if [ -f "$site_dir/settings.php" ]; then
                add_trusted_host "$site_name"
            fi
        fi
    done
else
    add_trusted_host "$TARGET"
fi
