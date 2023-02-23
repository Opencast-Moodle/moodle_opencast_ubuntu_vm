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
