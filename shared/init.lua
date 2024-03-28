-----------------------------------------------------------------------------------------------------------------------------------------
-- FRAMEWORK
-----------------------------------------------------------------------------------------------------------------------------------------
local vRPFramework = {
    ["flexin"] = true,
    ["creative_network"] = true,
    ["creative_v5"] = true,
    ["vrpex"] = true
}

if Config.Framework == "qbcore" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif vRPFramework[Config.Framework] then
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OX_INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
local ox_inventory = GetResourceState("ox_inventory"):find("start")
if ox_inventory then
    Framework[Config.Framework].AddItem = function(source,Item,Amount)
        return exports.ox_inventory:AddItem(source,Item,Amount)
    end

    Framework[Config.Framework].RemoveItem = function(source,Item,Amount)
        return exports.ox_inventory:RemoveItem(source,Item,Amount)
    end

    Framework[Config.Framework].CanCarryItem = function(source,Item,Amount)
        return exports.ox_inventory:CanCarryItem(source,Item,Amount)
    end

    Framework[Config.Framework].CountItem = function(source,Item)
        return exports.ox_inventory:Search(source,"count",Item)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALE
-----------------------------------------------------------------------------------------------------------------------------------------
lib.locale()