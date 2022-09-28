#!/bin/bash
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
