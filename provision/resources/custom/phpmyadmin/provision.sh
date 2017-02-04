#!/usr/bin/env bash

DIR=`dirname $0`

# Download phpMyAdmin
if [[ ! -d /srv/www/default/database-admin ]]; then
    echo "Downloading phpMyAdmin..."
    cd /srv/www/default
    wget -q -O phpmyadmin.tar.gz "https://files.phpmyadmin.net/phpMyAdmin/4.0.10.19/phpMyAdmin-4.0.10.19-all-languages.tar.gz"
    tar -xf phpmyadmin.tar.gz
    mv phpMyAdmin-4.0.10.19-all-languages database-admin
    # if doesn't work try with:
    if [ $? -ne 0 ]; then
        mkdir database-admin
        if [[ -d /srv/www/default/database-admin ]]; then
          mv phpMyAdmin-4.0.10.19-all-languages/* database-admin/
          if [ "$(ls -A phpMyAdmin-4.0.10.19-all-languages)" ]; then
            cp -ra phpMyAdmin-4.0.10.19-all-languages/* database-admin/
          else
            rmdir phpMyAdmin-4.0.10.19-all-languages/
          fi
        fi
    fi
    rm phpmyadmin.tar.gz
else
    echo "PHPMyAdmin already installed."
fi
cp "${DIR}/config.inc.php" "/srv/www/default/database-admin/"
