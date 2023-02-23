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
# Note, that this script must be executed with:
#   sh change_branch_moodle_plugins_opencast.sh <path> <branch>
#
# path:     The path to the Moodle repository, to update the plugins into.
#
# branch:   The branch, the branch of the plugins is changed to.
#
# This script changes the branch of the Opencast Moodle Plugins to the passed one.

set -e

repository_path="${1}"
branch="${2}"

working_dir=${PWD}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

for module_path in "admin/tool/opencast" "blocks/opencast" "local/chunkupload" "mod/opencast" "repository/opencast" "filter/opencast"
do
    echo "=> Changing branch of ${module_path} to ${branch}."
    
    cd ${repository_path}/${module_path}
    git checkout ${branch}
    cd ${working_dir}
    
    echo ""
done

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Successfully changed the branch of the Opencast Moodle Plugins in the Moodle repository ${repository_path} to ${branch}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
