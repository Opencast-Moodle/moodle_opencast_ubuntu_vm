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
# Note, that this script must be executed as superuser with:
#   sudo sh disable_static_file_server_authorization_check_opencast.sh
#
# This script disables the static file server authorization check of Opencast,
# that is enabled as default.
#
# You should run this script only, if the file
#   /etc/opencast/org.opencastproject.fsresources.StaticResourceServlet.cfg
# is in its default configuration.
# Furthermore, Elasticsearch and Opencast should not be running, when you execute this script.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "++++ Disabling static file server authorization check of Opencast +++++++++++++"
echo ""

# Stop services:
######################################################################################
systemctl stop apache2
######################################################################################

# Disable static file server authorization check of Opencast:
######################################################################################
servlet_config_file="org.opencastproject.fsresources.StaticResourceServlet.cfg"
opencast_config_dir="/etc/opencast"

default_config_line="#authentication.required = true"
config_line="authentication.required = false"

cd "${opencast_config_dir}"
sed -i "s/${default_config_line}/${config_line}/" "${servlet_config_file}"
######################################################################################

# Start services:
######################################################################################
systemctl start apache2
######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully disabled static file server authorization check of Opencast."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
