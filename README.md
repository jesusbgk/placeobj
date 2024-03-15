# placeobj
Description: Script to position props and give them functionality, with the possibility of adding countless props and countless functionality options to the props, limiting only creativity, being able to create items in the inventory directing the positioning of the script's props or be used via menu with permission, removes the item when placing the prop and adds when removing the prop.

Framework: STANDALONE

Settings available in the script:
- Add as many prop functionality options as you want in the config.
- Possibility to trigger client or server event in the options.
- Option to access the prop’s features via target or menu.
- Option to activate or deactivate the remove and add item function.
- Production configuration for the produce functionality already included in the script.

# Preview
https://youtu.be/MLaWFPpiPaQ

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