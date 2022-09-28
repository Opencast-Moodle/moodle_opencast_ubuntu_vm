#!/bin/bash
#
# Note, that this script must be executed as superuser with:
#   sudo sh integrate_lti_opencast.sh <consumer_name> <consumer_key> <consumer_secret>
#
# consumer_name: The name of the consumer.
#
# consumer_key: The key of the consumer.
#
# consumer_secret: The secret of the consumer.
#
# This script enables the integration of Opencast using LTI.
#
# You should run this script only, if the files
#   /etc/opencast/org.opencastproject.kernel.security.OAuthConsumerDetailsService.cfg
# and
#   /etc/opencast/org.opencastproject.security.lti.LtiLaunchAuthenticationHandler.cfg
# are in their default configuration.

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

consumer_name="${1}"
consumer_key="${2}"
consumer_secret="${3}"

echo ""
echo "++++ Enabling the integration of Opencast using LTI +++++++++++++++++++++++++++"
echo ""

# Stop services:
######################################################################################
systemctl stop opencast.service
systemctl stop elasticsearch.service
systemctl stop activemq.service
systemctl stop apache2
######################################################################################

# Enable OAuth in Opencast:
######################################################################################
default_security_config_file="mh_default_org.xml"
opencast_security_config_dir="/etc/opencast/security"

default_config_line="<!-- <ref bean=\"oauthProtectedResourceFilter\" \/> -->"
config_line="<ref bean=\"oauthProtectedResourceFilter\" \/>"

cd "${opencast_security_config_dir}"
sed -i "s/${default_config_line}/${config_line}/" "${default_security_config_file}"
######################################################################################

# Configure OAuth consumer:
######################################################################################
default_config_file="org.opencastproject.kernel.security.OAuthConsumerDetailsService.cfg"
opencast_config_dir="/etc/opencast"

default_config_line_consumer_name="#oauth.consumer.name.1=CONSUMERNAME"
config_line_consumer_name="oauth.consumer.name.1=${consumer_name}"

default_config_line_consumer_key="#oauth.consumer.key.1=CONSUMERKEY"
config_line_consumer_key="oauth.consumer.key.1=${consumer_key}"

default_config_line_consumer_secret="#oauth.consumer.secret.1=CONSUMERSECRET"
config_line_consumer_secret="oauth.consumer.secret.1=${consumer_secret}"

cd "${opencast_config_dir}"
sed -i "s/${default_config_line_consumer_name}/${config_line_consumer_name}/" "${default_config_file}"
sed -i "s/${default_config_line_consumer_key}/${config_line_consumer_key}/" "${default_config_file}"
sed -i "s/${default_config_line_consumer_secret}/${config_line_consumer_secret}/" "${default_config_file}"
######################################################################################

# Add rights/roles for consumer:
######################################################################################
default_config_file="org.opencastproject.security.lti.LtiLaunchAuthenticationHandler.cfg"
opencast_config_dir="/etc/opencast"

default_config_line_role_name="#lti.custom_role_name="
config_line_role_name="lti.custom_role_name="

default_config_line_roles="#lti.custom_roles="
config_line_roles="lti.custom_roles="

cd "${opencast_config_dir}"
sed -i "s/${default_config_line_role_name}/${config_line_role_name}/" "${default_config_file}"
sed -i "s/${default_config_line_roles}/${config_line_roles}/" "${default_config_file}"
######################################################################################

# Start services:
######################################################################################
systemctl start apache2
systemctl start activemq.service
systemctl start elasticsearch.service
systemctl start opencast.service
######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "Successfully enabled the integration of Opencast using LTI."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
