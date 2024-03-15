-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ObjectList = {}
InitObjects = {}
local Target = GetResourceState("ox_target"):find("start")
local Points = {}
local Selected
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
local function AddObject(Name,Prop,Number)
    local Ped = cache.ped
    local Placing = true
    local Object

    CreateThread(function()
        while Placing do
            DisablePlayerFiring(Ped,true)
            DisableControlAction(0,24,true)
            DisableControlAction(0,257,true) 
            DisableControlAction(0,25,true)
            DisableControlAction(0,175,true)
            DisableControlAction(0,174,true)
            
            local Hash = joaat(Prop)
            
            if not Object then
                if not HasModelLoaded(Hash) then
                    RequestModel(Hash)
                    Wait(10)
                end

                Object = CreateObject(Hash,GetCameraRayCastPosition(10),false,true,false)
                SetEntityAlpha(Object,102,1)
                SetEntityCollision(Object,false,false)
                PlaceObjectOnGroundProperly(Object)
            else
                SetEntityCoords(Object,GetCameraRayCastPosition(10),0,0,0,false)
                PlaceObjectOnGroundProperly(Object)

                DwText("~g~RIGHT MOUSE BUTTON~w~  CANCELAR",4,0.015,0.83,0.38,255,255,255,255)
                DwText("~g~LEFT MOUSE BUTTON~w~  COLOCAR OBJETO",4,0.015,0.86,0.38,255,255,255,255)
                DwText("~y~SCROLL UP~w~  GIRA ESQUERDA",4,0.015,0.89,0.38,255,255,255,255)
                DwText("~y~SCROLL DOWN~w~  GIRA DIREITA",4,0.015,0.92,0.38,255,255,255,255)

                if IsDisabledControlPressed(0,180) then
                    SetEntityHeading(Object,GetEntityHeading(Object) + 2)
                end

                if IsDisabledControlPressed(0,181) then
                    SetEntityHeading(Object,GetEntityHeading(Object) - 2)
                end

                if IsDisabledControlJustPressed(0,24) or IsDisabledControlJustPressed(0,257) then
                    Placing = false

                    local x,y,z = table.unpack(GetEntityCoords(Object))
                    local h = GetEntityHeading(Object)
                    local ObjectData = {
                        id = Number,
                        name = Name,
                        model = Prop,
                        x = tonumber(string.format("%.3f",x)),
                        y = tonumber(string.format("%.3f",y)),
                        z = tonumber(string.format("%.3f",z)),
                        h = tonumber(string.format("%.3f",h))
                    }
                    
                    if Object then
                        if DoesEntityExist(Object) then
                            DeleteEntity(Object)
                        end
            
                        Object = nil
                    end

                    if not DoesObjectOfTypeExistAtCoords(x,y,z,1.0,Hash,true) then
                        TriggerServerEvent("placeobj:server:AddObject",ObjectData)
                    else
                        Notify("warning","Objeto próximo encontrado.",5000)
                    end
                end
            end

            if IsDisabledControlJustPressed(0,25) then
                Placing = false

                if Object then
                    if DoesEntityExist(Object) then
                        DeleteEntity(Object)
                    end
        
                    Object = nil
                end

                TriggerServerEvent("placeobj:server:Cancel",Number)
            end

            Wait(0)
        end
    end)
end

exports("AddObject",AddObject)

RegisterNetEvent("placeobj:client:AddObject",AddObject)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
local function RemoveObject(Number)
    local Object = ObjectList[Number]
    if Object.entity and DoesEntityExist(Object.entity) then
        if Target then
            exports.ox_target:removeLocalEntity(Object.entity)
        else
            RemovePoint(Object.id)
        end

        DeleteEntity(Object.entity)
        InitObjects[Number] = nil
    end

    ObjectList[Number] = nil
end

exports("RemoveObject",RemoveObject)

RegisterNetEvent("placeobj:client:RemoveObject",RemoveObject)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:CLIENT:UPDATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:client:UpdateObject",function(Object)
    ObjectList[Object.id] = Object
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:CLIENT:SYNCOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:client:SyncObjects",function(Objects)
    ObjectList = Objects
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local function TargetOptions(Object)
    local Options = {
        {
            label = "Remover",
            icon = "fa-solid fa-hand",
            distance = 1.0,
            onSelect = function(data)
                TriggerServerEvent("placeobj:server:RemoveObject",Object.id)
            end
        }
    }

    local Prop = Config.PropList[Object.name]
    if Prop.options then
        for k,v in pairs(Prop.options) do
            if v.event then
                v.onSelect = function(data)
                    TriggerEvent(v.event,Object)
                end
            elseif v.serverEvent then
                v.onSelect = function(data)
                    TriggerServerEvent(v.serverEvent,Object)
                end
            end

            Options[#Options + 1] = v
        end
    end

    return Options
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCONTEXTMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local function RegisterContextMenu(Object)
    local Options = {
        {
            title = "Remover",
            description = "Remover objeto",
            icon = "fa-solid fa-hand",
            iconAnimation = "beat",
            onSelect = function(data)
                TriggerServerEvent("placeobj:server:RemoveObject",Object.id)
            end
        }
    }

    local Prop = Config.PropList[Object.name]
    if Prop.options then
        for k,v in pairs(Prop.options) do
            if v.event then
                v.onSelect = function(data)
                    TriggerEvent(v.event,Object)
                end
            elseif v.serverEvent then
                v.onSelect = function(data)
                    TriggerServerEvent(v.serverEvent,Object)
                end
            end

            Options[#Options + 1] = {
                title = v.label,
                description = v.label.." no objeto",
                icon = v.icon,
                iconAnimation = "beat",
                onSelect = v.onSelect
            }
        end
    end

    lib.registerContext({
        id = Object.name.."_menu",
        title = "Place Objects",
        options = Options
    })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
local function AddPoint(Object)
    Points[Object.id] = lib.points.new({
        coords = vec3(Object.coords.x,Object.coords.y,Object.coords.z),
        distance = 1.5
    })

    local Point = Points[Object.id]

    function Point:onEnter()
        Selected = Object
    end
     
    function Point:onExit()
        Selected = nil
    end

    RegisterContextMenu(Object)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePoint(Id)
    local Point = Points[Id]
    Point:remove()
    Points[Id] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERACT
-----------------------------------------------------------------------------------------------------------------------------------------
local Interact = lib.addKeybind({
    name = "PlaceObj",
    description = "Interact with objects when prompted",
    defaultKey = "E",
    onReleased = function(self)
        if not Selected then return end

        lib.showContext(Selected.name.."_menu")
    end
})
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        local Coords = GetEntityCoords(cache.ped)
        for k,v in pairs(ObjectList) do
            local Object = v
            local Distance = #(Coords - vec3(Object.coords.x,Object.coords.y,Object.coords.z))
            if Distance <= 100 then
                if not Object.active then
                    Object.active = true

                    if not HasModelLoaded(Object.model) then
                        RequestModel(Object.model)
                        while not HasModelLoaded(Object.model) do
                            Wait(5)
                        end
                    end

                    InitObjects[k] = CreateObject(Object.model,Object.coords.x,Object.coords.y,Object.coords.z,false,true)

                    while not DoesEntityExist(InitObjects[k]) do
                        Wait(5)
                    end

                    SetEntityHeading(InitObjects[k],Object.heading)
                    PlaceObjectOnGroundProperly(InitObjects[k])
                    FreezeEntityPosition(InitObjects[k],true)

                    Object.entity = InitObjects[k]

                    if Target then
                        exports.ox_target:addLocalEntity(Object.entity,TargetOptions(Object))
                    else
                        AddPoint(Object)
                    end
                end
            else
                if Object.active then
                    if Object.entity and DoesEntityExist(Object.entity) then
                        if Target then
                            exports.ox_target:removeLocalEntity(Object.entity)
                        else
                            RemovePoint(Object.id)
                        end

                        DeleteEntity(Object.entity)
                    end
                    
                    Object.active = false
                end
            end
        end

        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD START
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Options = {}
    for k,v in pairs(Config.PropList) do
        local Icon = v.icon or "table"

        Options[#Options + 1] = {
            title = v.label,
            description = "Prop: "..v.prop,
            icon = Icon,
            iconAnimation = "beat",
            image = "nui://placeobj/images/"..v.prop..".png",
            serverEvent = "placeobj:server:PlaceObjMenu",
            args = k
        }
    end

    lib.registerContext({
        id = "placeobj_menu",
        title = "Place Objects",
        options = Options
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
local function Open()
    lib.showContext("placeobj_menu")
end

exports("Open",Open)

RegisterNetEvent("placeobj:client:Open",Open)