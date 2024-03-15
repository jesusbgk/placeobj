-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Chairs = {
	[536071214] = 0.5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:CLIENT:SEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:client:Seat",function(Object)
	local Ped = cache.ped
	local Number = Object.id
	local Model = GetEntityModel(InitObjects[Number])
	local Heading = GetEntityHeading(InitObjects[Number])
	local Coords = GetEntityCoords(InitObjects[Number])
	SetEntityCoords(Ped,Coords.x,Coords.y,Coords.z + Chairs[Model],1,0,0,0)
	SetEntityHeading(Ped,Heading - 180.0)
	local PedCoords = GetEntityCoords(Ped)
	local PedHeading = GetEntityHeading(Ped)
	TaskStartScenarioAtPosition(Ped,"PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",PedCoords.x,PedCoords.y,PedCoords.z - 1,PedHeading,0,0,false)
end)