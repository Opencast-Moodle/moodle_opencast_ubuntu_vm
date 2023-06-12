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

# Define admin settings for tool_opencast.
$tool_opencast_admin_settings = array(
    'apiurl_1'              => '<apiurl>',
    'apiusername_1'         => '<apiusername>',
    'apipassword_1'         => '<apipassword>',
    'lticonsumerkey_1'      => '<lticonsumerkey>',
    'lticonsumersecret_1'   => '<lticonsumersecret>',
    'apitimeout_1'          => '0'  // Disable the timeout, to avoid issues with the known timeout bug (TODO: remove after its fix)
);

// ###################################################################################

# Define admin settings for block_opencast.
$block_opencast_admin_settings = array(
    'enable_opencast_studio_link_1'     => true,
    'show_opencast_studio_return_btn_1' => true,
    'series_name_1' => 'Course_Series_[COURSEID]'   // Set the default, to avoid an empty setting after installation (TODO: remove after its fix; see get_default_seriestitle in apibridge.php)
);

// ###################################################################################

# Define admin settings for mod_opencast.
$mod_opencast_admin_settings = array(
    'channel_1'             => 'engage-player',
    'download_channel_1'    => 'engage-player'
);

// ###################################################################################

// Set the defined admin settings.
$CFG->forced_plugin_settings = array(
    'tool_opencast'     => $tool_opencast_admin_settings,
    'block_opencast'    => $block_opencast_admin_settings,
    'mod_opencast'      => $mod_opencast_admin_settings
);

// ###################################################################################
