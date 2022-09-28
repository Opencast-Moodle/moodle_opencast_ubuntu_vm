#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh setup_opencast.sh <java_version> <opencast_version>
#
# java_version:     The java version to install (e.g., 11). Note, that for Opencast 10 and newer JDK 11 is supported only (state on 28.07.22).
# opencast_version: The stable Opencast major version to install (e.g., 11 (see https://opencast.org/category/releases/)).
#
# This script prepares the system for this Opencast installation and installs this Opencast version afterwards.
# See https://docs.opencast.org/r/11.x/admin/#installation/debs/ for further details.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
java_version="${1}"
opencast_version="${2}"

echo "The stable Opencast major version ${opencast_version} will be installed."
echo ""
read -p "Enter 'yes' to proceed or another text to abort:" userdecision
echo ""

if [ -z $userdecision ] || [ $userdecision != "yes" ]
then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo " ==> Aborted install of Opencast."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

sh "${setupdir}/prepare_opencast_install.sh" "${java_version}" "${opencast_version}"
sh "${setupdir}/install_opencast.sh" "${opencast_version}"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully installed Opencast."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
