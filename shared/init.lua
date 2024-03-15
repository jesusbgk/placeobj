-----------------------------------------------------------------------------------------------------------------------------------------
-- FRAMEWORK
-----------------------------------------------------------------------------------------------------------------------------------------
local vRPFramework = {
    ["flexin"] = true,
    ["creative_network"] = true,
    ["creative_v5"] = true,
    ["vrpex"] = true
}

if Config.Framework == "qb" then
    QBCore = exports.qb-core:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif vRPFramework[Config.Framework] then
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALE
-----------------------------------------------------------------------------------------------------------------------------------------
lib.locale()