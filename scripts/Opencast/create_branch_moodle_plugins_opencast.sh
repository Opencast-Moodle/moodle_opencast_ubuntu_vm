#!/bin/sh
######################################################################################
#
# Copyright (C) 2023 Matthias Kollenbroich
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
# Note, that this script must be executed with:
#   sh create_branch_moodle_plugins_opencast.sh <path> <branch>
#
# path:     The path to the Moodle repository, to update the plugins into.
#
# branch:   The branch, that is created for the plugins.
#
# This script creates the passed branch for the Opencast Moodle Plugins.

set -e

repository_path="${1}"
branch="${2}"

working_dir=${PWD}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

for module_path in "admin/tool/opencast" "blocks/opencast" "local/chunkupload" "mod/opencast" "repository/opencast" "filter/opencast"
do
    echo "=> Creating the branch ${branch} for ${module_path}."
    
    cd "${repository_path}/${module_path}"
    git branch "${branch}"
    cd "${working_dir}"
    
    echo ""
done

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Successfully created the branch ${branch} for the Opencast Moodle Plugins in the Moodle repository ${repository_path}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
