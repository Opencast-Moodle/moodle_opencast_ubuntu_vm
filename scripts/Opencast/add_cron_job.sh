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
#   sudo sh add_cron_job.sh <php_version> <absolute_moodle_root>
#
# <php_version>:            The php version, to run the cron job with. Note, that this version
#                           should match the version, that is run by your web server for Moodle.
# <absolute_moodle_root>:   The absolute path to the root directory of the version of Moodle,
#                           for that you would like to run the cron job regularly.
#
# This script adds the Moodle cron job, to be run regularly on the system
# by the user www-data of Apache.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

php_version="${1}"
absolute_moodle_root="${2}"

echo "++++ Adding Moodle cron job +++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

# Add to crontab:
######################################################################################
cronjob_user=www-data

crontab_command="* * * * * /usr/bin/php${php_version} ${absolute_moodle_root}/admin/cli/cron.php >/dev/null"
crontab -u ${cronjob_user} -l | { echo ""; echo "${crontab_command}"; echo ""; } | crontab -u ${cronjob_user} -
######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully added Moodle cron job with PHP ${php_version} for the Moodle version at ${absolute_moodle_root}."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
