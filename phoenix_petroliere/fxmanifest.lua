fx_version 'cerulean'
game 'gta5'

author 'lilfraae'
description 'New way to work in your RP city!'
version '1.0.0'

server_scripts {
    'server/jobs/fueler.lua',
    'server/sv_script.lua',
    'config.lua'
}

client_scripts {
    'client/jobs/fueler.lua',
    'client/cl_script.lua',
    'config.lua'
}

shared_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua'
}

dependencies {
	'es_extended'
}