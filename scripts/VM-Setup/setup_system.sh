#!/bin/sh
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
#   sudo sh setup_system.sh <php_version> <client_host_ip> <force_yes>
#
# php_version:      The additional PHP version to install and to set up Apache with (e.g., 8.0).
# client_host_ip:   The IP of the host of Xdebug sessions.
# force_yes:        Optional parameter, that can be passed.
#                   If force_yes is passed for this parameter, the script will be executed without
#                   a confirmation by the user.
#                   If another value is passed for this parameter, this parameter is ignored.
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
force_yes="${3:-ignore}"

echo "Git, cURL, MariaDB, Apache, PHP and Xdebug will be installed and configured."
echo ""

if [ $force_yes != "force_yes" ]
then
  read -p "Enter 'yes' to proceed or another text to abort:" userdecision
  echo ""

  if [ -z $userdecision ] || [ $userdecision != "yes" ]
  then
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      echo " ==> Aborted system setup."
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      exit 0
  fi
fi

sh "${setupdir}/install_git.sh"
sh "${setupdir}/install_curl.sh"
sh "${setupdir}/install_maria_db.sh"
sh "${setupdir}/install_apache_and_php.sh" "${php_version}"
sh "${setupdir}/install_xdebug.sh" "${php_version}" "${client_host_ip}"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully set up system."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
