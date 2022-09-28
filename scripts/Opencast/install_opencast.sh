#!/bin/bash
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
