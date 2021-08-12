fx_version 'cerulean'
game 'gta5'

author 'lilfraae'
description 'phoenix_lavori Modern and Responsive way to non-whitelisted jobs!'
version '1.1'

server_scripts {
    'server/jobs/*.lua',
    'server/sv_script.lua',
    'config.lua'
}

client_scripts {
    'client/jobs/*.lua',
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