#!/bin/bash
#
# Creates a Moodle config file (config.php).
#
# Note, that this script must be executed as superuser with:
#   sudo sh create_moodle_config.sh <name> <repository> <password>
#
# name:         The name of the Moodle installation.
# repository:   The name of the repository for the Moodle installation.
# password:     The password of the Moodle user for the database.
#
# Note, that the database with the name <name> and the Moodle user
# <name>_user for the database as well as the Moodle data directory
# /etc/moodle/<name> is used.
# In addition, the config file is created in the directory
# /var/www/html/<name>/<repository>
#
# Furthermore, the file setup_config.php is used as template for the
# final config file.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
name="${1}"
repository="${2}"
password="${3}"
moodleroot="/var/www/html/${name}/${repository}"
configfile="config.php"

cp -n "${setupdir}/setup_config.php" "${moodleroot}/${configfile}"
cd "${moodleroot}"

sed -i "s/<name>/${name}/" "${configfile}"
sed -i "s/<repository>/${repository}/" "${configfile}"
sed -i "s/<password>/${password}/" "${configfile}"

echo "Successfully created Moodle config for the Moodle root directory ${moodleroot}."
echo ""
