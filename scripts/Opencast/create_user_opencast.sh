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
#   sh create_user_opencast.sh <opencast_url> <admin_name> <admin_password>
#     <username> <password> <name> <email> <roles>
#
# opencast_url:   The URL for Opencast in the form <protocol>://<ip_address>:<port>.
# admin_name:     The name of an administrative account.
# admin_password: The password of the account specified with <admin_name>.
# username:       The username of the user to create.
# password:       The password of the user to create.
# name:           The name of the user to create.
# email:          The email of the user to create.
# roles:          The roles of the user to create. This is a list with the layout:
#                 '[{"name": "<name>", "type": "<type>"}, <...>]', whereat
#                 <name> is a role or a group name and
#                 <type> is INTERNAL or GROUP (INTERNAL is used for roles).
#
# This script creates a user for Opencast with the passed properties with the passed
# administrative account.
# Note, that Opencast must be running or this script will fail.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

opencast_url="${1}"
admin_name="${2}"
admin_password="${3}"
username="${4}"
password="${5}"
name="${6}"
email="${7}"
roles="${8}"

echo "++++ Creating user for Opencast +++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

# A retry loop is required, because Opencast may return invalid http error codes during start up:
set +e

curl_success=0
loop_counter=0
sleep_time=5
retries_count=10
while [ $loop_counter -le $retries_count ]
do
  if [ $loop_counter -gt 0 ]; then
    echo "Doing cURL retry ${loop_counter} of ${retries_count} in ${sleep_time} seconds ..."
    sleep ${sleep_time}
  fi

  curl -s -S -L -f --retry 5 -X POST "${opencast_url}/admin-ng/users" \
    --digest -u "${admin_name}:${admin_password}" \
    -H "X-Requested-Auth: Digest" \
    -F "username=${username}" \
    -F "password=${password}" \
    -F "name=${name}" \
    -F "email=${email}" \
    -F "roles=${roles}"

  if [ $? -eq 0 ]; then
    curl_success=1
    break
  fi

  loop_counter=$((loop_counter+1))
done

set -e

if [ $curl_success -ne 1 ]; then
  echo "cURL failed for all retries."
  exit 1
fi

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully created user for Opencast at ${opencast_url} with the properties: "
echo "Username: ${username}"
echo "Password: ${password}"
echo "Name:     ${name}"
echo "Email:    ${email}"
echo "Roles:    ${roles}"
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
