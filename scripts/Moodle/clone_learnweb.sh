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
# Clones learnweb and prepares the repository.
#
# Note, that this script must be executed with:
#   sudo sh create_moodle_data_directory.sh <path>
#
# path:     The path to the directory, to clone learnweb into.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

dirpath="${1}"

cd ${dirpath}
git clone git@wiwi-gitlab.uni-muenster.de:learnweb/learnweb.git
cd learnweb
git submodule init
git rm mod/ntprojectassembler
git rm blocks/ntproject_admin
git rm blocks/ntproject_ranking
git rm mod/ntproject
git submodule update --init --recursive
git config core.filemode false
git submodule foreach --recursive git config core.filemode false

echo ""
echo "Successfully cloned learnweb to the directory ${dirpath}/learnweb and prepared it."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
