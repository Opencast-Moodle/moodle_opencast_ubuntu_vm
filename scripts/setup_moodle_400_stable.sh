#!/bin/bash
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
