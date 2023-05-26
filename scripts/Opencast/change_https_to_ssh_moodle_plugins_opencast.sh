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
#   sh change_https_to_ssh_moodle_plugins_opencast.sh <path>
#
# path:     The path to the Moodle repository, to switch the remote URLs of the plugins for.
#
# This script switches the remote URLs from HTTPS to SSH for the Opencast Moodle Plugins.

set -e

repository_path="${1}"

working_dir=${PWD}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

for module in "tool" "block" "chunkupload" "mod" "repository" "filter"
do
    if [ "$module" = "tool" ]; then
        module_path="admin/tool/opencast"
        remote_url="git@github.com:Opencast-Moodle/moodle-tool_opencast.git"
        
    elif [ "$module" = "block" ]; then
        module_path="blocks/opencast"
        remote_url="git@github.com:Opencast-Moodle/moodle-block_opencast.git"
        
    elif [ "$module" = "chunkupload" ]; then
        module_path="local/chunkupload"
        remote_url="git@github.com:Opencast-Moodle/moodle-local_chunkupload.git"
        
    elif [ "$module" = "mod" ]; then
        module_path="mod/opencast"
        remote_url="git@github.com:Opencast-Moodle/moodle-mod_opencast.git"
        
    elif [ "$module" = "repository" ]; then
        module_path="repository/opencast"
        remote_url="git@github.com:Opencast-Moodle/moodle-repository_opencast.git"
        
    elif [ "$module" = "filter" ]; then
        module_path="filter/opencast"
        remote_url="git@github.com:Opencast-Moodle/moodle-filter_opencast.git"
        
    fi

    echo "=> Switching remote URL from HTTPS to SSH for ${module_path}."
    cd "${repository_path}/${module_path}"
    git remote set-url origin "${remote_url}"
    cd "${working_dir}"
    echo ""
done

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Successfully switched the remote URLs from HTTPS to SSH for the Opencast Moodle Plugins in the Moodle repository ${repository_path}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
