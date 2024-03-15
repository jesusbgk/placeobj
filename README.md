# Preview


# Dependencies
ox_lib - https://github.com/overextended/ox_lib

ox_target (optional) - https://github.com/overextended/ox_target

# Functions
-- CLIENT

exports["placeobj"]:Open()

TriggerEvent("placeobj:client:Open")

-- SERVER

exports["placeobj"]:PlaceObj(source,item)

TriggerEvent("placeobj:server:PlaceObj",source,Item)

TriggerEvent("placeobj:server:PlaceObjMenu",Item)