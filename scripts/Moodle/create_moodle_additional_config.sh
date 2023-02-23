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
# Creates a Moodle additional config file (additional_config.php).
#
# Note, that this script must be executed with:
#   sh create_moodle_additional_config.sh <name> <repository>
#     <apiurl> <apiusername> <apipassword> <lticonsumerkey> <lticonsumersecret>
#
# name:               The name of the Moodle installation.
# repository:         The name of the repository for the Moodle installation.
# apiurl:             The API URL.
# apiusername:        The API username.
# apipassword:        The API password.
# lticonsumerkey:     The LTI consumer key.
# lticonsumersecret:  The LTI consumer secret.
#
# The additional config file is created in the directory
# /var/www/html/<name>/<repository>
#
# Furthermore, the file setup_additional_config.php is used as template for the
# final additional config file.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
name="${1}"
repository="${2}"
apiurl="${3}"
apiusername="${4}"
apipassword="${5}"
lticonsumerkey="${6}"
lticonsumersecret="${7}"

moodleroot="/var/www/html/${name}/${repository}"
additional_configfile="additional_config.php"

cp -n "${setupdir}/setup_additional_config.php" "${moodleroot}/${additional_configfile}"
cd "${moodleroot}"

apiurl_escaped=$(echo $apiurl | sed 's/\//\\\//g') # escape all slashes

sed -i "s/<apiurl>/${apiurl_escaped}/" "${additional_configfile}"
sed -i "s/<apiusername>/${apiusername}/" "${additional_configfile}"
sed -i "s/<apipassword>/${apipassword}/" "${additional_configfile}"
sed -i "s/<lticonsumerkey>/${lticonsumerkey}/" "${additional_configfile}"
sed -i "s/<lticonsumersecret>/${lticonsumersecret}/" "${additional_configfile}"

echo "Successfully created Moodle additional config for the Moodle root directory ${moodleroot}."
echo ""
