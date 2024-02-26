---@alias Framework
---| '"ESX"'
---| '"QB"'
---| '"auto"'


---@alias TargetSystem
---| '"ox_target"'
---| '"qb_target"'
---| '"qtarget"'
---| '"auto"'


---@alias InventorySystem
---| '"ox_inventory"'
---| '"qb-inventory"'
---| '"auto"'


---@alias AccountType
---| '"bank"'
---| '"money"'

AddBlipForCoord(Config.blip1.x, Config.blip1.y, Config.blip1.z)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local playerCoords = GetEntityCoords(PlayerPedId())
		local deliveryCoords = vec3(Config.blip1.x, Config.blip1.y, Config.blip1.z)

		local distance = #(playerCoords - deliveryCoords)

		if distance < 5 then
			lib.showTextUI("[E] - Deliver Pizza")
			if IsControlPressed(0, 38) then
				print("testje")
				local item = xplayer.HasItem("pizza")
				if item then
					xPlayer.removeInventoryItem("pizza", 1)
					xPlayer.addInventoryItem("payslip", 1)
				else
					lib.notify({
						title = "Pizza job",
						description = "You dont have any pizzas",
						type = "success"
					})
				end
			elseif distance < 10 then
				lib.hideTextUI()
			end
		end
	end
end)
