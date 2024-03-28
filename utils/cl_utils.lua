-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONTODIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }

    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }

    return direction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMERARAYCASTPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCameraRayCastPosition(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }

    local a,b,c,d,e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x,cameraCoord.y,cameraCoord.z,destination.x,destination.y,destination.z,-1,-1,1))

    return c
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Notify(Type,Message,Duration,Title,Id,Position,Icon,IconColor)
    Position = Position or "center-right"

    lib.notify({
        id = Id,
        title = Title,
        description = Message,
        duration = Duration,
        position = Position,
        type = Type,
        style = {
            backgroundColor = "#0C0C11F6",
            color = "#C1C2C5",
            [".description"] = {
                color = "#909296"
            }
        },
        icon = Icon,
        iconColor = IconColor,
        iconAnimation = "beat"
    })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function PlayAnim(Dict,Name,Flag)
    Flag = Flag or 48

	lib.requestAnimDict(Dict)
	TaskPlayAnim(cache.ped,Dict,Name,8.0,8.0,-1,Flag,0,0,0,0)
	RemoveAnimDict(Dict)
end

RegisterNetEvent("placeobj:client:PlayAnim",PlayAnim)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function StopAnim()
    ClearPedTasks(cache.ped)
end

RegisterNetEvent("placeobj:client:StopAnim",StopAnim)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEOBJ:CLIENT:PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:client:Progress",function(Label,Duration,Cancel)
	lib.progressBar({
		duration = Duration,
		label = Label,
		position = Position,
		canCancel = Cancel,
        disable = {
            move = true
        }
	})
end)