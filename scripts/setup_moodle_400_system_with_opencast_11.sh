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
#   sudo sh setup_moodle_400_system_with_opencast_11.sh

set -e

######################################################################################
# Configuration variables:

php_version=7.4

java_version=11
opencast_version=11

moodle_version=400

# Configuration variables - END
######################################################################################

sh setup_moodle_system_with_opencast.sh ${php_version} \
  ${java_version} ${opencast_version} \
  ${moodle_version}

######################################################################################
