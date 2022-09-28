#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh setup_system.sh <php_version> <client_host_ip>
#
# php_version:      The additional PHP version to install and to set up Apache with (e.g., 8.0).
# client_host_ip:   The IP of the host of Xdebug sessions.
#
# This script installs MariaDB, Apache web server, PHP as well as a working Apache-PHP environment.
# In addition, it installs the specified PHP version and sets up Apache with this version as well as Xdebug.
#
# Apache will be accessible afterwards with https://localhost via its default SSL configuration.
# Note, that Apache will be running and will be started after booting automatically after running this script.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
php_version="${1}"
client_host_ip="${2}"

echo "MariaDB, Apache, PHP and Xdebug will be installed and configured."
echo ""
read -p "Enter 'yes' to proceed or another text to abort:" userdecision
echo ""

if [ -z $userdecision ] || [ $userdecision != "yes" ]
then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo " ==> Aborted system setup."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

sh "${setupdir}/install_maria_db.sh"
sh "${setupdir}/install_apache_and_php.sh" "${php_version}"
sh "${setupdir}/install_xdebug.sh" "${php_version}" "${client_host_ip}"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully set up system."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
