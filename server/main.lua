-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ActiveObjects = {}
local WaitResponse = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
	if (GetCurrentResourceName() == Resource) then
        local LoadFile = LoadResourceFile(GetCurrentResourceName(),"./objects.json")
        if LoadFile then
            local Objects = json.decode(LoadFile)
            if type(Objects) == "table" then
                ActiveObjects = Objects
            end
        end
	end 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
function PlaceObj(source,Item)
	if not source or not Item then return end

    local Prop = Config.PropList[Item].prop
    if not Prop then return end

    local Number = (#WaitResponse + 1)
    WaitResponse[Number] = true
    TriggerClientEvent("placeobj:client:AddObject",source,Item,Prop,Number)

    while (not ActiveObjects[Number] and WaitResponse[Number]) do
        Wait(10)
    end

    return ActiveObjects[Number]
end

exports("PlaceObj",PlaceObj)

RegisterNetEvent("placeobj:server:PlaceObj",PlaceObj)

RegisterNetEvent("placeobj:server:PlaceObjMenu",function(Item)
    local src = source
    PlaceObj(src,Item)
end)

RegisterCommand(Config.Command,function(source,Message)
    local src = source
	if not Config.Perm or Functions.Permission(src,Config.Perm) then
		TriggerClientEvent("placeobj:client:Open",src)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:SERVER:ADDOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:server:AddObject",function(Object)
    local src = source
    local Identifier = Functions.Identifier(src)
	if not Identifier then
        TriggerEvent("placeobj:server:Cancel",Object.id)
        return
    end

    if Config.RemoveItem then
        if not Functions.RemoveItem(src,Object.name,1) then
            TriggerEvent("placeobj:server:Cancel",Object.id)
            return
        end
    end

    ActiveObjects[Object.id] = {
		id = Object.id,
        name = Object.name,
        model = Object.model,
        coords = vector3(Object.x,Object.y,Object.z),
        heading = Object.h,
        owner = Identifier
    }

    SaveResourceFile(GetCurrentResourceName(),"objects.json",json.encode(ActiveObjects,{ indent = true }),-1)
    TriggerClientEvent("placeobj:client:UpdateObject",-1,ActiveObjects[Object.id])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:SERVER:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:server:Cancel",function(Number)
    if not WaitResponse[Number] then return end
    WaitResponse[Number] = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:SERVER:REMOVEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:server:RemoveObject",function(Number)
    local src = source
    local Object = ActiveObjects[Number]
	if not Object then return end

	local Item = Object.name
    if not Item then return end

    if Config.RemoveItem then
        Functions.AddItem(src,Item,1)
    end

    ActiveObjects[Number] = nil
    SaveResourceFile(GetCurrentResourceName(),"objects.json",json.encode(ActiveObjects,{ indent = true }),-1)
    TriggerClientEvent("placeobj:client:RemoveObject",-1,Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:SERVER:CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:server:Connect",function(source)
	TriggerClientEvent("placeobj:client:SyncObjects",source,ActiveObjects)
end)

Functions.Connect()