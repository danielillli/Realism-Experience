fx_version 'cerulean'
game 'gta5'

author 'danielillli'
description 'Realism Experience with Vehicle Spawner and Repair'
version '1.0.0'

-- Define the resource metadata
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Specify the script entry points
client_script 'client.lua'
server_script 'server.lua'

-- Add any other necessary files, such as configuration or utility scripts
files {
    'index.html',
    'script.js',
    'style.css'
}

ui_page 'index.html'
