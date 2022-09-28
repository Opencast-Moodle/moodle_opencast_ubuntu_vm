#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh install_xdebug.sh <php_version> <client_host_ip>
#
# php_version:      The PHP version to install Xdebug for.
# client_host_ip:   The IP of the host of Xdebug sessions.
#
# This script installs Xdebug for Apache.
# The logs of Xdebug will be stored at /etc/xdebug/logs.
# Note, that the idekey of Xdebug will be PHPSTORM and that the config in php.ini will be not updated,
# if it already exists.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

php_version="${1}"
client_host_ip="${2}"

echo "++++ Installing Xdebug ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

apt-get -y install php${php_version}-xdebug

php_ini_path="/etc/php/${php_version}/apache2/php.ini"

# Write Xdebug config only, if it does not exist already:
if ! grep -q "Xdebug" "${php_ini_path}"; then
    echo "" >> "${php_ini_path}"
    echo "; Xdebug" >> "${php_ini_path}"
    echo "xdebug.client_host = ${client_host_ip}" >> "${php_ini_path}"
    echo "xdebug.mode = debug" >> "${php_ini_path}"
    echo "xdebug.idekey = PHPSTORM" >> "${php_ini_path}"
    echo "xdebug.start_with_request = yes" >> "${php_ini_path}"
    echo "xdebug.log = /etc/xdebug/logs/xdebug.log" >> "${php_ini_path}"
fi

mkdir -p /etc/xdebug/logs
chmod 0777 /etc/xdebug/logs

systemctl restart apache2

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed Xdebug."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
