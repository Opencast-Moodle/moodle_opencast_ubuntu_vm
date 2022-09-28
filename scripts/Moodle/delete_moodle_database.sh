#!/bin/bash
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
