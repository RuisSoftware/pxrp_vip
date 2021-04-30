fx_version 'cerulean'
game "gta5"

name "pxrp-vip"
author "KingRyuShin"

description 'VIP Status - Dutch Players Edit'

version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

dependencies {
	'es_extended'
}