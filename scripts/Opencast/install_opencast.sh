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
#   sudo sh install_opencast.sh <opencast_version>
#
# opencast_version: The stable Opencast major version to install (e.g., 11 (see https://opencast.org/category/releases/)).
#
# This script installs Opencast and configures the services activemq, elasticsearch and opencast to be started
# automatically after booting.
# See https://docs.opencast.org/r/11.x/admin/#installation/debs/ for further details.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

opencast_version="${1}"

echo "++++ Installing stable Opencast major version ${opencast_version} ++++++++++++++++++++++++++++++"
echo ""

apt-get -y install opencast-${opencast_version}-allinone elasticsearch-oss activemq-dist ffmpeg-dist
cp /usr/share/opencast/docs/scripts/activemq/activemq.xml /etc/activemq/activemq.xml

systemctl enable activemq.service
systemctl enable elasticsearch.service
systemctl enable opencast.service

systemctl start activemq.service
systemctl start elasticsearch.service
systemctl start opencast.service

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed stable Opencast major version ${opencast_version}."
echo "Note, that Apache ActiveMQ, Elasticsearch and Opencast are automatically started after booting and are running, now."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
