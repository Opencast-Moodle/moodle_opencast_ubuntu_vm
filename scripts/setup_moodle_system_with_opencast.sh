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
# Note, that this script must be executed from the scripts directory as superuser with:
#   sudo sh setup_moodle_system_with_opencast.sh
#
# This script set ups the system, installs Moodle and Opencast as well as configures them.
# This process includes the installation and configuration of the Opencast Moodle Plugins.
# Moodle will be installed at /var/www/html afterwards.
#
# WARNING: You should run this script only, if the system is in its default initial state
# and the latest updates are installed for the system.

set -e

######################################################################################
# Configuration variables:

php_version=7.4

java_version=11
opencast_version=11

moodle_version=400

# Configuration variables - END
######################################################################################

echo "The system will be set up, Moodle and Opencast will be installed as well as configured."
echo "WARNING: You should run this script only, if the system is in its default initial state
and the latest updates are installed for the system."
echo ""
read -p "Enter 'yes' to proceed or another text to abort:" userdecision
echo ""

if [ -z $userdecision ] || [ $userdecision != "yes" ]
then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo " ==> Aborted system setup, Moodle and Opencast installation as well as configuration."
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

######################################################################################
# Helper variables:

xdebug_client_host_ip=192.168.56.1

moodle_install_dir="/var/www/html"
moodle_installation_name="moodle_${moodle_version}_stable"
moodle_repository_name=moodle

moodle_database_user_password="moodle-pass"
moodle_admin_account_password="Admin12#34"

opencast_protocol=http
opencast_ip=192.168.56.101
opencast_port=8081

opencast_system_account_name=opencast_system_account
opencast_system_account_password=CHANGE_ME

opencast_api_user_roles='[
  {"name": "ROLE_API", "type": "INTERNAL"},
  {"name": "ROLE_API_CAPTURE_AGENTS_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_ACL_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_ACL_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_ACL_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_CREATE", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_MEDIA_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_METADATA_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_METADATA_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_METADATA_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_PUBLICATIONS_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_SCHEDULING_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_SCHEDULING_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_EVENTS_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_GROUPS_CREATE", "type": "INTERNAL"},
  {"name": "ROLE_API_GROUPS_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_GROUPS_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_GROUPS_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_SECURITY_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_ACL_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_ACL_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_CREATE", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_METADATA_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_METADATA_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_METADATA_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_PROPERTIES_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_PROPERTIES_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_SERIES_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_STATISTICS_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_WORKFLOW_DEFINITION_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_API_WORKFLOW_INSTANCE_CREATE", "type": "INTERNAL"},
  {"name": "ROLE_API_WORKFLOW_INSTANCE_DELETE", "type": "INTERNAL"},
  {"name": "ROLE_API_WORKFLOW_INSTANCE_EDIT", "type": "INTERNAL"},
  {"name": "ROLE_API_WORKFLOW_INSTANCE_VIEW", "type": "INTERNAL"},
  {"name": "ROLE_SUDO", "type": "INTERNAL"},
  {"name": "ROLE_GROUP_MH_DEFAULT_ORG_EXTERNAL_APPLICATIONS", "type": "GROUP"}
]'

opencast_api_user_name="moodle_user";
opencast_api_user_password="moodle-pass";

opencast_lti_consumer_name=moodle_user_consumer
opencast_lti_consumer_key=moodle_user_consumer_key
opencast_lti_consumer_secret=moodle_user_consumer_secret

opencast_api_url="${opencast_protocol}://${opencast_ip}:${opencast_port}"

# Helper variables - END
######################################################################################

# Set up system:
sh VM-Setup/setup_system.sh ${php_version} ${xdebug_client_host_ip} force_yes

######################################################################################

# Set up Opencast:
sh Opencast/setup_opencast.sh ${java_version} ${opencast_version} force_yes

sh Opencast/add_external_access_opencast.sh ${opencast_protocol} ${opencast_ip} ${opencast_port}

sh Opencast/disable_static_file_server_authorization_check_opencast.sh

sh Opencast/integrate_lti_opencast.sh ${opencast_lti_consumer_name} ${opencast_lti_consumer_key} \
  ${opencast_lti_consumer_secret}

sh Opencast/create_user_opencast.sh ${opencast_api_url} \
  ${opencast_system_account_name} ${opencast_system_account_password} \
  ${opencast_api_user_name} ${opencast_api_user_password} \
  ${opencast_api_user_name} "${opencast_api_user_name}@localhost" "${opencast_api_user_roles}"

######################################################################################

# Set up Moodle:
mkdir -p "${moodle_install_dir}/${moodle_installation_name}"
sh Moodle/clone_moodle.sh "${moodle_install_dir}/${moodle_installation_name}" ${moodle_version}

sh Moodle/create_moodle_additional_config.sh ${moodle_installation_name} ${moodle_repository_name} \
  ${opencast_api_url} ${opencast_api_user_name} ${opencast_api_user_password} \
  ${opencast_lti_consumer_key} ${opencast_lti_consumer_secret}

sh Opencast/install_moodle_plugins_opencast.sh "${moodle_install_dir}/${moodle_installation_name}/${moodle_repository_name}"

sh Moodle/install_moodle.sh ${moodle_installation_name} ${moodle_repository_name} ${moodle_database_user_password} \
  ${php_version} ${moodle_admin_account_password} ${opencast_port} force_yes

sh Opencast/add_cron_job.sh ${php_version} "${moodle_install_dir}/${moodle_installation_name}/${moodle_repository_name}"

######################################################################################

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " ==> Successfully set up system, installed Moodle and Opencast as well as configured them."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
