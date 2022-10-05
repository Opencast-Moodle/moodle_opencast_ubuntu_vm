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
<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

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

// Force a debugging mode regardless the settings in the site administration
@error_reporting(E_ALL | E_STRICT);   // NOT FOR PRODUCTION SERVERS!
@ini_set('display_errors', '1');         // NOT FOR PRODUCTION SERVERS!
$CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!
$CFG->debugdisplay = 1;              // NOT FOR PRODUCTION SERVERS!

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
