#!/bin/bash
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

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "++++ Disabling static file server authorization check of Opencast +++++++++++++"
echo ""

# Stop services:
######################################################################################
systemctl stop opencast.service
systemctl stop elasticsearch.service
systemctl stop activemq.service
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
systemctl start activemq.service
systemctl start elasticsearch.service
systemctl start opencast.service
######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully disabled static file server authorization check of Opencast."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
