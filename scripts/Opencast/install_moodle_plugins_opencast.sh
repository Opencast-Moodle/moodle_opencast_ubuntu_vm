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
# Note, that this script must be executed with:
#   sh install_moodle_plugins_opencast.sh <path>
#
# path:     The path to the Moodle repository, to clone/install the plugins into.
#
# This script clones/installs the Opencast Moodle Plugins as submodules to the
# passe Moodle repository.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

repository_path="${1}"

echo "++++ Cloning the Opencast Moodle Plugins ++++++++++++++++++++++++++++++++++++++"
echo ""

cd ${repository_path}

git submodule add https://github.com/Opencast-Moodle/moodle-tool_opencast.git admin/tool/opencast
git submodule add https://github.com/Opencast-Moodle/moodle-block_opencast.git blocks/opencast
git submodule add https://github.com/Opencast-Moodle/moodle-local_chunkupload.git local/chunkupload
git submodule add https://github.com/Opencast-Moodle/moodle-mod_opencast.git mod/opencast
git submodule add https://github.com/Opencast-Moodle/moodle-repository_opencast.git repository/opencast
git submodule add https://github.com/Opencast-Moodle/moodle-filter_opencast.git filter/opencast

echo ""
echo "Successfully cloned the Opencast Moodle Plugins as submodules to the Moodle repository ${repository_path}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
