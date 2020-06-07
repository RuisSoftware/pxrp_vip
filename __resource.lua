resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

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
