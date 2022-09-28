#!/bin/bash
#
# Deletes a Moodle data directory.
#
# Note, that this script must be executed as superuser with:
#   sudo sh delete_moodle_data_directory.sh <name>
#
# name:     The data directory for Moodle will be deleted at the path
#           /etc/moodle/<name>_data

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

dirpath="/etc/moodle/${1}_data"

rm -rf ${dirpath}

echo "Successfully deleted Moodle data directory ${dirpath}."
echo ""
