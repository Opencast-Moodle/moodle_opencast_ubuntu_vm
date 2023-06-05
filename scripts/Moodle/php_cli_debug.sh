#!/bin/sh
######################################################################################
#
# Copyright (C) 2023 Matthias Kollenbroich
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
# Note, that this script must be executed with:
#   sh php_cli_debug.sh <client_host> <ide_server_name> <php_file> <params>
#
# <client_host>:            The address of the client host, namely, the address of the
#                           host running IntelliJ.
# <ide_server_name>:        The name of the server for the corresponding debug file mapping
#                           of IntelliJ under Preferences -> Languages & Frameworks -> PHP -> Servers.
# <php_file>:               The path to the PHP file, that is going to be debugged.
# <params>:                 The parameters, that are passed for the PHP file.
#
# This script starts a debug session for the passed PHP CLI file with the passed parameters
# with IntelliJ and Xdebug. Note, that a file mapping for IntelliJ and the server must be configured.

set -e

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

client_host="${1}"
ide_server_name="${2}"
php_file="${3}"
params="${4}"

echo "Starting PHP CLI debug session for:"
echo "${php_file}"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

######################################################################################

export PHP_IDE_CONFIG="serverName=${ide_server_name}"
php -dxdebug.mode=debug -dxdebug.client_host="${client_host}" -dxdebug.client_port=9003 -dxdebug.start_with_request=yes "${php_file}" "${params}"

######################################################################################

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Closed PHP CLI debug session for:"
echo "${php_file}"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
