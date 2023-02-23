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
# Installs Moodle by running install_database.php.
#
# Note, that this script must be executed as superuser with:
#   sudo sh run_moodle_installer.sh <name> <repository> <php_version>
#
# name:             The name of the Moodle installation.
# repository:       The name of the repository for the Moodle installation.
# php_version:      The version of PHP, that is used for the installation (e.g., 7.4).
# admin_password:   The password of the admin account with the name admin of the Moodle installation.
#
# Note, that the source of the Moodle version must be included in the directory:
#   /var/www/html/<name>/<repository>

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

name="${1}"
repository="${2}"
moodleroot="/var/www/html/${name}/${repository}"
phpversion="${3}"
adminpassword="${4}"

cd ${moodleroot}
chown www-data .
cd admin/cli
sudo -u www-data "/usr/bin/php${phpversion}" install_database.php --agree-license \
  --adminpass="${adminpassword}" --fullname="${name}" --shortname="${repository}" --adminemail="${name}@example.com"
cd ../..
chown -R root .

echo ""
echo "Successfully installed Moodle version for the Moodle root directory ${moodleroot}."
echo ""
