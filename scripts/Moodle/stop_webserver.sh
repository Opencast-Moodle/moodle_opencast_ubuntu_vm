#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh stop_webserver.sh

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

systemctl stop apache2

echo "Successfully stopped web server."
echo ""
