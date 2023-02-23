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
# Creates a Moodle database as well as a Moodle user with privileges,
# to access this database.
#
# Note, that this script must be executed as superuser with:
#   sudo sh create_moodle_database.sh <name> <password>
#
# name:     The name of the Moodle database. The Moodle user gets the name
#           <name>_user.
#
# password: The password of the Moodle user.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

databasename="$1"
username="${databasename}_user"
password="$2"

mysql -e "CREATE DATABASE ${databasename} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "CREATE USER ${username}@localhost IDENTIFIED BY '${password}';"
mysql -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON ${databasename}.* TO ${username}@localhost;"
mysql -e "FLUSH PRIVILEGES;"

echo "Successfully created Moodle database ${databasename} and Moodle user ${username}."
echo ""
