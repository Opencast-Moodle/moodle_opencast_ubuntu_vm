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
# Deletes a Moodle database as well as the corresponding Moodle user.
#
# Note, that this script must be executed as superuser with:
#   sudo sh delete_moodle_database.sh <name>
#
# name:     The name of the Moodle database to delete. The Moodle user with the name
#           <name>_user is deleted, too.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

databasename="$1"
username="${databasename}_user"

mysql -e "DROP DATABASE ${databasename};"
mysql -e "DROP USER '${username}'@'localhost';"

echo "Successfully deleted Moodle database ${databasename} and Moodle user ${username}."
echo ""
