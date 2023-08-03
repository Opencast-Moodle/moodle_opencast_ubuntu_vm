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
#   sudo sh install_opencast.sh <opencast_version>
#
# opencast_version: The stable Opencast major version to install (e.g., 13 (see https://opencast.org/category/releases/)).
#                   Note, that the passed version must be at least 13.
#
# This script installs Opencast and configures the services elasticsearch or opensearch and opencast to be started
# automatically after booting.
# See for further details:
# - https://docs.opencast.org/r/13.x/admin/#installation/debs/
# - https://docs.opencast.org/r/14.x/admin/#installation/debs/
# Furthermore, Elasticsearch or OpenSearch should not be running, when you execute this script.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

opencast_version="${1}"

echo "++++ Installing stable Opencast major version ${opencast_version} ++++++++++++++++++++++++++++++"
echo ""

# Note, that starting with Opencast 14, OpenSearch is now a dependency.
if [ ${opencast_version} -lt "14" ]; then
  apt-get -y install opencast-${opencast_version}-allinone elasticsearch-oss ffmpeg-dist
else
  apt-get -y install opencast-${opencast_version}-allinone opensearch ffmpeg-dist
fi

# Apply invalid zip64 extra data field size fix:
######################################################################################
setenv_file="setenv"
opencast_bin_dir="/usr/share/opencast/bin"

default_config_part="{EXTRA_JAVA_OPTS}"
config_part="{EXTRA_JAVA_OPTS} -Djdk.util.zip.disableZip64ExtraFieldValidation=true"

cd "${opencast_bin_dir}"
sed -i "s/${default_config_part}/${config_part}/" "${setenv_file}"
######################################################################################

systemctl start opencast.service
systemctl enable opencast.service

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed stable Opencast major version ${opencast_version}."
echo "Note, that Elasticsearch or OpenSearch and Opencast are automatically started after booting."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
