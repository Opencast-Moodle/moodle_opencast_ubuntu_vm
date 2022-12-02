<?php
// ###################################################################################
//
// Copyright (C) 2022 Matthias Kollenbroich
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see https://www.gnu.org/licenses/.
//
// ###################################################################################

unset($CFG);
global $CFG;
$CFG = new stdClass();

// ###################################################################################

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = '<name>';
$CFG->dbuser    = '<name>_user';
$CFG->dbpass    = '<password>';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
  'dbcollation' => 'utf8mb4_unicode_ci',
);

$CFG->wwwroot   = 'https://192.168.56.101/<name>/<repository>';
$CFG->dataroot  = '/etc/moodle/<name>_data';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 02777;

// ###################################################################################

//// Force a debugging mode regardless the settings in the site administration
//@error_reporting(E_ALL | E_STRICT);   // NOT FOR PRODUCTION SERVERS!
//@ini_set('display_errors', '1');         // NOT FOR PRODUCTION SERVERS!
//$CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!
//$CFG->debugdisplay = 1;              // NOT FOR PRODUCTION SERVERS!

// ###################################################################################

// Use for curlsecurityblockedhosts the default values except of 192.168.0.0/16 for Opencast:
$CFG->curlsecurityblockedhosts = "
127.0.0.1
10.0.0.0/8
172.16.0.0/12
0.0.0.0
localhost
169.254.169.254
0000::1
";

// Use for curlsecurityallowedport the default values and the port for Opencast:
$CFG->curlsecurityallowedport = "
443
80
<opencast_port>
";

// ###################################################################################

// Require additional_config.php, if it exists:
$additional_config_file="additional_config.php";
if (file_exists(__DIR__ . '/' . $additional_config_file)) {
    require_once $additional_config_file;
}

// ###################################################################################

require_once(__DIR__ . '/lib/setup.php');

// ###################################################################################

