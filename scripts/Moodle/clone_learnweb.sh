#!/bin/bash
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
