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
# Installs Moodle.
#
# Note, that this script must be executed as superuser with:
#   sudo sh install_moodle.sh <name> <repository> <password> <php_version>
#
# name:             The name of the Moodle installation.
# repository:       The name of the repository for the Moodle installation.
# password:         The password of the Moodle user for the database.
# php_version:      The version of PHP, that is used for the installation (e.g., 7.4).
# admin_password:   The password of the admin account with the name admin of the Moodle installation.
#
# Note, that the source of the Moodle version must be included in the directory and
# that this Moodle version is installed:
#   /var/www/html/<name>/<repository>
#
# Note, that the database with the name <name> and the Moodle user
# <name>_user for the database as well as the Moodle data directory
# /etc/moodle/<name> will be created and used.
# In addition, the config file will be created in the directory:
#   /var/www/html/<name>/<repository>

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
name="${1}"
repository="${2}"
password="${3}"
phpversion="${4}"
adminpassword="${5}"
moodleroot="/var/www/html/${name}/${repository}"

echo "The Moodle version with the name ${name} will be installed."
echo ""
read -p "Enter 'yes' to proceed or another text to abort:" userdecision
echo ""

if [ -z $userdecision ] || [ $userdecision != "yes" ]
then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo " ==> Aborted install of Moodle."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

sh "${setupdir}/stop_webserver.sh"

sh "${setupdir}/create_moodle_data_directory.sh" "${name}"
sh "${setupdir}/create_moodle_database.sh" "${name}" "${password}"
sh "${setupdir}/create_moodle_config.sh" "${name}" "${repository}" "${password}"
sh "${setupdir}/run_moodle_installer.sh" "${name}" "${repository}" "${phpversion}" "${adminpassword}"

sh "${setupdir}/start_webserver.sh"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully installed Moodle."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
