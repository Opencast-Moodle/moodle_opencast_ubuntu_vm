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
# Note, that this script must be executed from the scripts directory with:
#   sudo sh setup_moodle_400_stable.sh

set -e

sh VM-Setup/setup_system.sh 7.4 192.168.56.1
sh Opencast/setup_opencast.sh 11 11
sh Opencast/add_external_access_opencast.sh http 192.168.56.101 8081
sh Opencast/disable_static_file_server_authorization_check_opencast.sh
sh Moodle/install_moodle.sh moodle_400_stable moodle moodle-pass 7.4 "Admin12#34"
sh Opencast/add_cron_job.sh 7.4 /var/www/html/moodle_400_stable/moodle
sh Opencast/integrate_lti_opencast.sh moodle_user_consumer moodle_user_consumer_key moodle_user_consumer_secret
