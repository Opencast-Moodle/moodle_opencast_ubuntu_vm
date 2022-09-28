#!/bin/bash
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
