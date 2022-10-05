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
# Uninstalls Moodle.
#
# Note, that this script must be executed as superuser with:
#   sudo sh uninstall_moodle.sh <name>
#
# name:             The name of the Moodle installation.
#
# Note, that the source of the Moodle version must be included in the directory:
#   /var/www/html/<name>
#
# Note, that the database with the name <name> and the Moodle user
# <name>_user for the database as well as the Moodle data directory
# /etc/moodle/<name> will be deleted.
# In addition, the directory /var/www/html/<name> will be deleted, too.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
name="${1}"
moodledir="/var/www/html/${name}"

echo "The Moodle version with the name ${name} will be uninstalled and the directory ${moodledir} will be deleted."
echo ""
read -p "Enter 'yes' to proceed or another text to abort:" userdecision
echo ""

if [ -z $userdecision ] || [ $userdecision != "yes" ]
then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo " ==> Aborted uninstall of Moodle."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

sh "${setupdir}/stop_webserver.sh"

sh "${setupdir}/delete_moodle_data_directory.sh" "${name}"
sh "${setupdir}/delete_moodle_database.sh" "${name}"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
rm -rf "${moodledir}"
echo "Successfully deleted Moodle directory ${moodledir}."
echo ""

sh "${setupdir}/start_webserver.sh"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully uninstalled Moodle."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
