-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Framework = {
	["qbcore"] = {
		Identifier = function(source)
			local Player = QBCore.Functions.GetPlayer(source)
			return Player.PlayerData.citizenid
		end,

        Permission = function(source,Permission)
			return QBCore.Functions.HasPermission(source,Permission)
		end,

		AddItem = function(source,Item,Amount)
			local Player = QBCore.Functions.GetPlayer(source)
			Player.Functions.AddItem(Item,Amount)
		end,

		RemoveItem = function(source,Item,Amount)
			local Player = QBCore.Functions.GetPlayer(source)
			local Consult = Player.Functions.GetItemByName(Item)
			if Consult.amount >= Amount then
				Player.Functions.RemoveItem(Item,Amount)
				return true
			end

			return false
        end,

		CanCarryItem = function(source,Item,Amount)
			return true
		end,

		CountItem = function(source,Item)
			local Amount = 0
			local Player = QBCore.Functions.GetPlayer(source)
			local Consult = Player.Functions.GetItemByName(Item)
			if Consult and Consult.amount then
				Amount = Consult.amount
			end

			Return Amount
		end,

		Connect = function()
			AddEventHandler("QBCore:Server:OnPlayerLoaded",function()
				local src = source
                TriggerEvent("placeobj:server:Connect",src)
            end)
		end
	},
	["esx"] = {
		Identifier = function(source)
			local Player = ESX.GetPlayerFromId(source)
			return Player.identifier
		end,

        Permission = function(source,Permission)
			local Player = ESX.GetPlayerFromId(source)
			return Player.getGroup() == Permission
		end,

		AddItem = function(source,Item,Amount)
			local Player = ESX.GetPlayerFromId(source)
			Player.addInventoryItem(Item,Amount)
		end,

		RemoveItem = function(source,Item,Amount)
			local Player = ESX.GetPlayerFromId(source)
			local Consult = Player.getInventoryItem(Item)
			if Consult.count >= Amount then
				Player.removeInventoryItem(Item,Amount)
				return true
			end

			return false
        end,

		CanCarryItem = function(source,Item,Amount)
			return true
		end,

		CountItem = function(source,Item)
			local Amount = 0
			local Player = ESX.GetPlayerFromId(source)
			local Consult = Player.getInventoryItem(Item)
			if Consult and Consult.count then
				Amount = Consult.count
			end

			return Amount
		end,

		Connect = function()
			AddEventHandler("esx:playerLoaded",function()
				local src = source
                TriggerEvent("placeobj:server:Connect",src)
            end)
		end
	},
    ["flexin"] = {
		Identifier = function(source)
			return vRP.Passport(source)
		end,

        Permission = function(source,Permission)
			local Identifier = vRP.Passport(source)
			return vRP.HasGroup(Identifier,Permission)
		end,

        AddItem = function(source,Item,Amount)
			return exports.ox_inventory:AddItem(source,Item,Amount)
		end,

		RemoveItem = function(source,Item,Amount)
			return exports.ox_inventory:RemoveItem(source,Item,Amount)
		end,

		CanCarryItem = function(source,Item,Amount)
			return exports.ox_inventory:CanCarryItem(source,Item,Amount)
		end,

		CountItem = function(source,Item)
			return exports.ox_inventory:Search(source,"count",Item)
		end,

		Connect = function()
			AddEventHandler("Connect",function(Passport,source)
                TriggerEvent("placeobj:server:Connect",source)
            end)
		end
	},
	["creative_network"] = {
		Identifier = function(source)
			return vRP.Passport(source)
		end,

        Permission = function(source,Permission)
			local Identifier = vRP.Passport(source)
			return vRP.HasGroup(Identifier,Permission)
		end,

        AddItem = function(source,Item,Amount)
			local Identifier = vRP.Passport(source)
			return vRP.GenerateItem(Identifier,Item,Amount,true)
		end,

		RemoveItem = function(source,Item,Amount)
			local Identifier = vRP.Passport(source)
			return vRP.TakeItem(Identifier,Item,Amount,true)
		end,

		CanCarryItem = function(source,Item,Amount)
			local Identifier = vRP.Passport(source)
			return (vRP.InventoryWeight(Identifier) + itemWeight(Item) * Amount) <= vRP.GetWeight(Identifier)
		end,

		CountItem = function(source,Item)
			local Identifier = vRP.Passport(source)
			return vRP.InventoryItemAmount(Identifier,Item)[1]
		end,

		Connect = function()
			AddEventHandler("Connect",function(Passport,source)
                TriggerEvent("placeobj:server:Connect",source)
            end)
		end
	},
	["creative_v5"] = {
		Identifier = function(source)
			return vRP.getUserId(source)
		end,

        Permission = function(source,Permission)
			local Identifier = vRP.getUserId(source)
			return vRP.hasGroup(Identifier,Permission)
		end,

        AddItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return vRP.generateItem(Identifier,Item,Amount,true)
		end,

		RemoveItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return vRP.tryGetInventoryItem(Identifier,Item,Amount,true)
		end,

		CanCarryItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return (vRP.inventoryWeight(Identifier) + itemWeight(Item) * Amount) <= vRP.getWeight(Identifier)
		end,

		CountItem = function(source,Item)
            local Identifier = vRP.getUserId(source)
			return vRP.getInventoryItemAmount(Identifier,Item)[1]
		end,

		Connect = function()
			AddEventHandler("playerConnect",function(Passport,source)
                TriggerEvent("placeobj:server:Connect",source)
            end)
		end
	},
	["vrpex"] = {
		Identifier = function(source)
			return vRP.getUserId(source)
		end,

        Permission = function(source,Permission)
			local Identifier = vRP.getUserId(source)
			return vRP.hasPermission(Identifier,Permission)
		end,

        AddItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return vRP.giveInventoryItem(Identifier,Item,Amount,true)
		end,

		RemoveItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return vRP.tryGetInventoryItem(Identifier,Item,Amount,false)
		end,

		CanCarryItem = function(source,Item,Amount)
			local Identifier = vRP.getUserId(source)
			return (vRP.getInventoryWeight(Identifier) + vRP.getItemWeight(Item) * Amount) <= vRP.getInventoryMaxWeight(Identifier)
		end,

		CountItem = function(source,Item)
            local Identifier = vRP.getUserId(source)
			return vRP.getInventoryItemAmount(Identifier,Item)
		end,

		Connect = function()
			AddEventHandler("playerJoining",function()
				local src = source
                TriggerEvent("placeobj:server:Connect",src)
            end)
		end
	}
}

Functions = Framework[Config.Framework] or {}