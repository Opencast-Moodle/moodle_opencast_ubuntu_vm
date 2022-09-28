#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh install_maria_db.sh
#
# This script installs MariaDB.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "++++ Installing MariaDB +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

apt-get -y install mariadb-server

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully installed MariaDB."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
