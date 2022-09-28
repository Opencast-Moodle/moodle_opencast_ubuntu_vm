#!/bin/bash
#
# Note, that this script must be executed with:
#   sudo sh install_moodle_plugins_opencast.sh.sh <path>
#
# path:     The path to the Moodle repository, to clone/install the plugins into.
#
# This script clones/installs the Opencast Moodle Plugins as submodules to the
# passe Moodle repository.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

repository_path="${1}"

cd ${repository_path}

git submodule add https://github.com/Opencast-Moodle/moodle-tool_opencast.git admin/tool/opencast 
git submodule add https://github.com/Opencast-Moodle/moodle-block_opencast.git blocks/opencast 
git submodule add https://github.com/Opencast-Moodle/moodle-local_chunkupload.git local/chunkupload 
git submodule add https://github.com/Opencast-Moodle/moodle-mod_opencast.git mod/opencast 
git submodule add https://github.com/Opencast-Moodle/moodle-repository_opencast.git repository/opencast
git submodule add https://github.com/Opencast-Moodle/moodle-filter_opencast.git filter/opencast

echo ""
echo "Successfully cloned/installed the Opencast Moodle Plugins as submodules to the Moodle repository ${repository_path}."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
