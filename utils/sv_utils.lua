-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Notify(source,Type,Message,Duration,Title,Id,Position,Icon,IconColor)
    Position = Position or "center-right"

    TriggerClientEvent("ox_lib:notify",source,
        { 
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
        }
    )
end