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
#   sh merge_squash_moodle_plugins_opencast.sh <repository_path> <plugin_name>
# <source_branch> <target_branch> <commit_message>
#
# repository_path:  The path to the Moodle repository, to update the plugin into.
#
# plugin_name:      The name of the plugin, to perform the merge for.
#                   Supported names are:
#                   tool, block, chunkupload, mod, repository, filter
#
# source_branch:    The branch, from that is merged.
#
# target_branch:    The branch, into that is merged.
#
# commit_message:   The commit message, of the created commit.
#
# This script merges the passed source branch into the passed target branch by
# a squash for the passed plugin name, namely, a single commit on top of
# this target branch is created, whose effect is the same as merging
# this source branch into this target branch.
# This merge is a fast-forward merge, when possible.
# When a fast-forward merge is not not possible, the merge is aborted
# and the script fails.
# The current branch for the passed plugin name will be the passed target branch,
# if this script was executed successfully.
# The commit message for the created commit is the passed commit message.

set -e

repository_path="${1}"
plugin_name="${2}"
source_branch="${3}"
target_branch="${4}"
commit_message="${5}"

working_dir=${PWD}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

if [ "${plugin_name}" = "tool" ]; then
    module_path="admin/tool/opencast"
elif [ "${plugin_name}" = "block" ]; then
    module_path="blocks/opencast"
elif [ "${plugin_name}" = "chunkupload" ]; then
    module_path="local/chunkupload"
elif [ "${plugin_name}" = "mod" ]; then
    module_path="mod/opencast"
elif [ "${plugin_name}" = "repository" ]; then
    module_path="repository/opencast"
elif [ "${plugin_name}" = "filter" ]; then
    module_path="filter/opencast"
else
    echo "The passed plugin name is unknown. Exiting ..."
    echo ""
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo ""

    exit 1
fi

cd ${repository_path}/${module_path}

git checkout ${target_branch}
git merge --ff-only --squash ${source_branch}
git commit -m "${commit_message}"

cd ${working_dir}

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Successfully fast-forward merged the branch ${source_branch} into the branch ${target_branch} by a squash for the Opencast Moodle Plugin ${plugin_name} in the Moodle repository ${repository_path} and created a commit with the message \"${commit_message}\" for this merge."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
