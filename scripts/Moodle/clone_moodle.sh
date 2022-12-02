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
# Clones the Moodle repository and switches this repository to the passed version of
# the Moodle stable branch.
#
# Note, that this script must be executed with:
#   sh clone_moodle.sh <path> <version>
#
# path:     The path to the directory, to clone Moodle into.
# version:  The version of the Moodle stable branch.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

dirpath="${1}"
version="${2}"

echo "++++ Cloning Moodle +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

cd ${dirpath}
git clone -b MOODLE_${version}_STABLE git://git.moodle.org/moodle.git

echo ""
echo "Successfully cloned Moodle to the directory ${dirpath}/moodle and switched to the Moodle stable branch ${version}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
