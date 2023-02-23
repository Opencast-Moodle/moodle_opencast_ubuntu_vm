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
# This script installs Opencast and configures the services elasticsearch and opencast to be started
# automatically after booting.
# See https://docs.opencast.org/r/13.x/admin/#installation/debs/ for further details.
# Furthermore, Elasticsearch should not be running, when you execute this script.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

opencast_version="${1}"

echo "++++ Installing stable Opencast major version ${opencast_version} ++++++++++++++++++++++++++++++"
echo ""

apt-get -y install opencast-${opencast_version}-allinone elasticsearch-oss ffmpeg-dist

systemctl enable elasticsearch.service
systemctl enable opencast.service

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed stable Opencast major version ${opencast_version}."
echo "Note, that Elasticsearch and Opencast are automatically started after booting."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
