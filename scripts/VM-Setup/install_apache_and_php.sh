#!/bin/bash
######################################################################################
#
# Copyright (C) 2022 Matthias Kollenbroich
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see https://www.gnu.org/licenses/.
#
######################################################################################
#
# Note, that this script must be executed as superuser with:
#   sudo sh install_apache_and_php.sh <php_version>
#
# php_version: The additional PHP version to install and to set up Apache with (e.g., 8.0).
#
# This script installs the Apache web server, PHP as well as a working Apache-PHP environment.
# In addition, it installs the specified PHP version and sets up Apache with this version.
# For this PHP version, all required packages for Moodle are installed, too, as well as
# max_input_vars is set to 5000 in the php.ini of Apache for this PHP version (recommended for Moodle).
#
# Apache will be accessible afterwards with https://localhost via its default SSL configuration.
# Note, that Apache will be running and will be started after booting automatically after running this script.
#
# Furthermore, www-data is added to the user group vboxsf of the VirtualBox VM.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

php_version="${1}"

echo "++++ Installing Apache and PHP ++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

apt-get -y install php

echo ""
echo "++++ Installing PHP ${php_version} ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

add-apt-repository -y ppa:ondrej/ubuntu/php

apt -y install php${php_version}

apt -y install php${php_version}-mysqli
apt -y install php${php_version}-xml
apt -y install php${php_version}-mbstring
apt -y install php${php_version}-curl
apt -y install php${php_version}-zip
apt -y install php${php_version}-gd
apt -y install php${php_version}-intl
apt -y install php${php_version}-xmlrpc
apt -y install php${php_version}-soap

echo ""
echo "++++ Setting up Apache with PHP ${php_version} ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

default_php_version=$(php -r "\$version = explode('.', PHP_VERSION); echo \$version[0] . '.' . \$version[1];")

a2dismod php${default_php_version}
a2enmod php${php_version}

# Set max_input_vars in php.ini:
max_input_vars_value="5000"
sed -i "s/;max_input_vars = 1000/max_input_vars = ${max_input_vars_value}/" "/etc/php/${php_version}/apache2/php.ini"

a2enmod ssl
a2ensite default-ssl

# Remove the default page of Apache:
rm -f "/var/www/html/index.html"

adduser www-data vboxsf

systemctl restart apache2

# Set the link after setting up Apache with PHP, to avoid errors with Apache:
update-alternatives --set php /usr/bin/php${php_version}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed Apache and PHP as well as installed PHP ${php_version} and set up Apache with PHP ${php_version}."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
