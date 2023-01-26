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
# Note, that this script must be executed as superuser with:
#   sudo sh add_external_access_opencast.sh <protocol> <ip_address> <port>
#
# protocol:     The protocol to use (must be http or https)
# ip_address:   The ip address, to make Opencast reachable with.
# port:         The port, to make Opencast reachable with.
#
# This script makes Opencast reachable over Apache via the passed ip address over the passed port
# via the passed protocol by adding an additional configuration to Apache (opencast_http.conf or opencast_https.conf).
# You can access Opencast afterwards with: <protocol>://<ip_address>:<port>
# Note, that this script should be executed only, if Apache is in its default configuration
# as well as org.opencastproject.server.url has its default value in /etc/opencast/custom.properties
# and if the passed port is not in use (e.g., use 8081 as port for http and use 8443 as port for https).
# Furthermore, Elasticsearch and Opencast should not be running, when you execute this script.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setup_dir="$(dirname "${0}")"
protocol="${1}"
ip_address="${2}"
port="${3}"

if [ -z $protocol ] || ([ $protocol != "http" ] && [ $protocol != "https" ])
then
    echo "Error: The passed protocol ${protocol} is neither http nor https."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 1
fi

echo "++++ Adding external access to Opencast +++++++++++++++++++++++++++++++++++++++"
echo ""

# Stop services:
######################################################################################
systemctl stop apache2
######################################################################################

# Add opencast.conf to Apache:
######################################################################################
a2enmod headers
a2enmod proxy
a2enmod proxy_http

config_file_source="opencast_${protocol}.conf"
config_file="opencast.conf"
sides_dir="/etc/apache2/sites-available"

cp -n "${setup_dir}/${config_file_source}" "${sides_dir}/${config_file}"
cd "${sides_dir}"
sed -i "s/<ip_address>/${ip_address}/" "${config_file}"
sed -i "s/<port>/${port}/" "${config_file}"
a2ensite opencast.conf
######################################################################################

# Add port via SSL to Apache:
######################################################################################
cd ..
ports_file="ports.conf"
# Write port config only, if it does not exist already:
if ! grep -q "Listen ${port}" "${ports_file}"; then
    echo "" >> "${ports_file}"
    
    if [ $protocol = "http" ]
    then
        echo "Listen ${port}" >> "${ports_file}"
    else
        echo "<IfModule ssl_module>" >> "${ports_file}"
        echo "	Listen ${port}" >> "${ports_file}"
        echo "</IfModule>" >> "${ports_file}"
    fi
    
    echo "" >> "${ports_file}"
fi
######################################################################################

# Add ip address and port to Opencast custom.properties
######################################################################################
properties_file="custom.properties"
opencast_config_dir="/etc/opencast"

default_server_url="org.opencastproject.server.url=http:\/\/localhost:8080"
new_server_url="org.opencastproject.server.url=${protocol}:\/\/${ip_address}:${port}"

cd "${opencast_config_dir}"
sed -i "s/${default_server_url}/${new_server_url}/" "${properties_file}"
######################################################################################

# Start services:
######################################################################################
systemctl start apache2
######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully added external access to Opencast via ${protocol}://${ip_address}:${port}."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
