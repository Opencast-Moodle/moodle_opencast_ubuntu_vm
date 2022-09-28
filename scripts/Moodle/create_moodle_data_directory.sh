#!/bin/bash
#
# Creates a Moodle data directory and sets the access rights for this
# directory correctly.
#
# Note, that this script must be executed as superuser with:
#   sudo sh create_moodle_data_directory.sh <name>
#
# name:     The data directory for Moodle will be created at the path
#           /etc/moodle/<name>_data

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

dirpath="/etc/moodle/${1}_data"

mkdir -p ${dirpath}
chmod 0777 ${dirpath}

echo "Successfully created Moodle data directory ${dirpath}."
echo ""
