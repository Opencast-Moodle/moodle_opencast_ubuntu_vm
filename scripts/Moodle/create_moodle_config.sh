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
# Creates a Moodle config file (config.php).
#
# Note, that this script must be executed as superuser with:
#   sudo sh create_moodle_config.sh <name> <repository> <password>
#
# name:           The name of the Moodle installation.
# repository:     The name of the repository for the Moodle installation.
# password:       The password of the Moodle user for the database.
# opencast_port:  The port, at which Opencast is reachable.
#
# Note, that the database with the name <name> and the Moodle user
# <name>_user for the database as well as the Moodle data directory
# /etc/moodle/<name> is used.
# In addition, the config file is created in the directory
# /var/www/html/<name>/<repository>
#
# Furthermore, the file setup_config.php is used as template for the
# final config file and the file additional_config.php may be added to the
# directory of the final config.php, to expand it.
# additional_config.php is required in the final config.php, if it
# exists in this directory.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
name="${1}"
repository="${2}"
password="${3}"
opencast_port="${4}"
moodleroot="/var/www/html/${name}/${repository}"
configfile="config.php"

cp -n "${setupdir}/setup_config.php" "${moodleroot}/${configfile}"
cd "${moodleroot}"

sed -i "s/<name>/${name}/" "${configfile}"
sed -i "s/<repository>/${repository}/" "${configfile}"
sed -i "s/<password>/${password}/" "${configfile}"
sed -i "s/<opencast_port>/${opencast_port}/" "${configfile}"

echo "Successfully created Moodle config for the Moodle root directory ${moodleroot}."
echo ""
