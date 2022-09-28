#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh start_webserver.sh

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

systemctl restart apache2

echo "Successfully started web server."
echo ""
