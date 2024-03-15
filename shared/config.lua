-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {}

Config.Framework = "flexin" -- (qb, esx, flexin, creative_network, creative_v5, vrpex)
Config.Command = "placeobj" -- comando para adicionar algum objeto ao servidor
Config.Perm = "Admin" -- permissão para adicionar algum objeto ao servidor coloque false para deixar sem verificação de permissão
Config.RemoveItem = true -- remover item para colocar o prop coloque false para não remover

Config.PropList = {
    ["engine"] = {
		label = "Motor",
		prop = "prop_car_engine_01"
	},
	["battery"] = {
		label = "Bateria",
		icon = "car-battery",
		prop = "prop_battery_02"
	},
	["tyre"] = {
		label = "Pneu",
		prop = "prop_stockade_wheel"
	},
	["barrier"] = {
		label = "Barreira",
		icon = "road-barrier",
		prop = "prop_barrier_wat_03a"
	},
	["barrier2"] = {
		label = "Barreira 2",
		icon = "road-barrier",
		prop = "prop_barrier_work06b"
	},
	["chair"] = {
		label = "Cadeira",
		icon = "chair",
		prop = "prop_off_chair_01",
		options = {
			{
				label = "Sentar",
				icon = "fa-solid fa-chair",
				distance = 1.0,
				event = "placeobj:client:Seat"
			},
			{
				label = "Sentar",
				icon = "fa-solid fa-chair",
				distance = 1.0,
				event = "placeobj:client:Seat"
			}
		}
	},
	["tablecoke"] = {
		label = "Bancada de cocaína",
		prop = "bkr_prop_coke_table01a",
		options = {
			{
				label = "Produzir",
				icon = "fa-solid fa-flask",
				distance = 1.0,
				serverEvent = "placeobj:server:MakeProducts"
			}
		}
	},
	["tableweed"] = {
		label = "Bancada de maconha",
		icon = "cannabis",
		prop = "bkr_prop_weed_table_01a",
		options = {
			{
				label = "Produzir",
				icon = "fa-solid fa-flask",
				distance = 1.0,
				serverEvent = "placeobj:server:MakeProducts"
			}
		}
	},
	["tablemeth"] = {
		label = "Bancada de metanfetamina",
		prop = "bkr_prop_meth_table01a",
		options = {
			{
				label = "Produzir",
				icon = "fa-solid fa-flask",
				distance = 1.0,
				serverEvent = "placeobj:server:MakeProducts"
			}
		}
	},
	["tableweapon"] = {
		label = "Bancada de armas",
		icon = "gun",
		prop = "gr_prop_gr_bench_02b"
	},
	["washer"] = {
		label = "Máquina de lavar",
		prop = "prop_washer_02"
	}
}

Config.Products = {
	["tablecoke"] = {
		{ 
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "sulfuric", ["amount"] = 1 },
				{ ["item"] = "cokeleaf", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "cocaine",
			["itemAmount"] = 3
		}
	},
	["tablemeth"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "saline", ["amount"] = 1 },
				{ ["item"] = "acetone", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "meth",
			["itemAmount"] = 3
		}
	},
	["tableweed"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "silk", ["amount"] = 1 },
				{ ["item"] = "weedleaf", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "joint",
			["itemAmount"] = 3
		}
	}
}