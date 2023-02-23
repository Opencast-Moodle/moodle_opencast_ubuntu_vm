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
#   sudo sh setup_opencast.sh <java_version> <opencast_version> <force_yes>
#
# java_version:     The java version to install (e.g., 11). Note, that for Opencast 10 and newer JDK 11 is supported only (state on 28.07.22).
# opencast_version: The stable Opencast major version to install (e.g., 13 (see https://opencast.org/category/releases/)).
#                   Note, that the passed version must be at least 13.
# force_yes:        Optional parameter, that can be passed.
#                   If force_yes is passed for this parameter, the script will be executed without
#                   a confirmation by the user.
#                   If another value is passed for this parameter, this parameter is ignored.
#
# This script prepares the system for this Opencast installation and installs this Opencast version afterwards.
# See https://docs.opencast.org/r/11.x/admin/#installation/debs/ for further details.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

setupdir="$(dirname "${0}")"
java_version="${1}"
opencast_version="${2}"
force_yes="${3:-ignore}"

echo "The stable Opencast major version ${opencast_version} will be installed."
echo ""

if [ $force_yes != "force_yes" ]
then
  read -p "Enter 'yes' to proceed or another text to abort:" userdecision
  echo ""

  if [ -z $userdecision ] || [ $userdecision != "yes" ]
  then
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      echo " ==> Aborted install of Opencast."
      echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      exit 0
  fi
fi

sh "${setupdir}/prepare_opencast_install.sh" "${java_version}" "${opencast_version}"
sh "${setupdir}/install_opencast.sh" "${opencast_version}"

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully installed Opencast."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
