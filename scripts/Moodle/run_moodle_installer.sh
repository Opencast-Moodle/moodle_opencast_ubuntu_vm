#!/bin/bash
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
sudo -u www-data "/usr/bin/php${phpversion}" install_database.php --agree-license --adminpass="${adminpassword}" --fullname="${name}" --shortname="${repository}"
cd ../..
chown -R root .

echo ""
echo "Successfully installed Moodle version for the Moodle root directory ${moodleroot}."
echo ""
