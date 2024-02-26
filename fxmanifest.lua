fx_version "cerulean"
game "gta5"
lua54 "yes"

author "CFX Store"
version "0.0.0"

server_scripts {
	"modules/**/server.lua",
	"wrappers/**/server.lua"
}

client_scripts {
	"modules/**/client.lua",
	"wrappers/**/client.lua"
}

shared_scripts {
	"init.lua",
	"config/*.lua",
	"modules/**/shared.lua",
}

files {
	"import.lua",
}