fx_version "bodacious"
game "gta5"
lua54 "yes"

name "placeobj"
description "placeobj"
author "JesusBGK"
version "1.1.3"

shared_scripts {
	"@ox_lib/init.lua",
	"@vrp/lib/Utils.lua",
	-- "@vrp/config/Item.lua",
	-- "@vrp/lib/itemlist.lua",
	"shared/*.lua"
}

client_scripts {
	"utils/cl_utils.lua",
	"client/*"
}

server_scripts {
	"utils/sv_utils.lua",
	"server/*",
	"@oxmysql/lib/MySQL.lua"
}

files {
	"images/*",
	"locales/*.json"
}