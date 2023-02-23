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
#   sudo sh prepare_opencast_install.sh <java_version> <opencast_version>
#
# java_version:     The java version to install (e.g., 11). Note, that for Opencast 13 and newer JDK 11 is supported only (state on 01/24/2023).
# opencast_version: The stable Opencast major version to install (e.g., 13 (see https://opencast.org/category/releases/)).
#                   Note, that the passed version must be at least 13.
#
# This script should be executed only once before you install Opencast.
# It installs a JDK and Elasticsearch as well as activates repositories for Opencast.
# See https://docs.opencast.org/r/11.x/admin/#installation/debs/ for further details.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

java_version="${1}"
opencast_version="${2}"

echo "++++ Installing Java ${java_version} +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

apt-get -y install openjdk-${java_version}-jre

echo ""
echo "++++ Activating repositories for stable Opencast major version ${opencast_version} +++++++++++++"
echo ""

apt-get -y install apt-transport-https ca-certificates wget gnupg2
echo "deb https://pkg.opencast.org/debian ${opencast_version}.x stable" | tee /etc/apt/sources.list.d/opencast.list
wget -qO - https://pkg.opencast.org/gpgkeys/opencast-deb.key | apt-key add -
apt-get -y update

echo ""
echo "++++ Installing Elasticsearch +++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

apt-get -y install elasticsearch-oss

systemctl stop elasticsearch.service

cat > /etc/elasticsearch/jvm.options.d/log4shell.options << EOF
-Dlog4j2.formatMsgNoLookups=true
EOF

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed Java ${java_version} and prepared stable Opencast major version ${opencast_version} installation."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
