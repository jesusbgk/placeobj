-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("placeobj:server:MakeProducts",function(Object)
	local src = source
	local Identifier = Functions.Identifier(src)
	if Identifier and not Active[Identifier] then
		local Selected = Object.name
        local Product = Config.Products[Selected]

		if Product then
			local Need = {}
			local Number = math.random(#Product)

			if Product[Number]["item"] then
				if not Functions.CanCarryItem(src,Product[Number]["item"],Product[Number]["itemAmount"]) then
					Notify(src,"error","Mochila cheia.",5000)
					return
				end
			end

			if Product[Number]["need"] then
				local NeedItem = Product[Number]["need"]
				if type(NeedItem) == "table" then
					for k,v in pairs(NeedItem) do
						local Count = Functions.CountItem(src,v["item"])
						if Count < v["amount"] then
							Notify(src,"warning","Necessário possuir "..v["amount"].."x "..v["item"]..".",5000)
							return
						end

						Need[k] = { v["item"],v["amount"] }
					end
				else
					local NeedAmount = Product[Number]["needAmount"]
					local Count = Functions.CountItem(src,NeedItem)

					if Count < NeedAmount then
						Notify(src,"warning","Necessário possuir "..NeedAmount.."x "..NeedItem..".",5000)
						return
					end
				end
			end

			Active[Identifier] = os.time() + Product[Number]["timer"]
			TriggerClientEvent("placeobj:client:Progress",src,"Produzindo",Product[Number]["timer"] * 1000,false)

			if Selected == "tablecoke" then
				TriggerClientEvent("placeobj:client:PlayAnim",src,"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter")
			elseif Selected == "tablemeth" then
				TriggerClientEvent("placeobj:client:PlayAnim",src,"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter")
			elseif Selected == "tableweed" then
				TriggerClientEvent("placeobj:client:PlayAnim",src,"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter")
			end

			repeat
				if os.time() >= Active[Identifier] then
					TriggerClientEvent("placeobj:client:StopAnim",src)
					Active[Identifier] = nil

					if Product[Number]["need"] then
						if type(Product[Number]["need"]) == "table" then
							for k,v in pairs(Need) do
								Functions.RemoveItem(src,v[1],v[2])
							end
						else
							Functions.RemoveItem(src,Product[Number]["need"],Product[Number]["needAmount"])
						end
					end

					if Product[Number]["item"] then
						Functions.AddItem(src,Product[Number]["item"],Product[Number]["itemAmount"])
					end
				end

				Wait(100)
			until not Active[Identifier]
		end
	end
end)