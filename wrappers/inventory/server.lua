cfx.inventory = {}

---@param source number
---@param item string
---@param count? number
function cfx.inventory.addItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = function()
			exports.ox_inventory:AddItem(source, item, count or 1)
		end,
		["qb-inventory"] = function()
			local player = cfx.player.getFromId(source)
			player.frameworkPlayer.Functions.AddItem(item, count or 1)
		end
	})

	return caller()
end

---@param source number
---@param item string
---@param count? number
function cfx.inventory.removeItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = function()
			exports.ox_inventory:RemoveItem(source, item, count or 1)
		end,
		["qb-inventory"] = function()
			local player = cfx.player.getFromId(source)
			player.frameworkPlayer.Functions.RemoveItem(item, count or 1)
		end
	})

	return caller()
end

---@param source number
---@param item string
function cfx.inventory.getItemCount(source, item)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = function()
			return exports.ox_inventory:Search(source, 'count', item)
		end,
		["qb-inventory"] = function()
			local player = cfx.player.getFromId(source)
			return #player.frameworkPlayer.Functions.GetItemByName(item)
		end
	})

	return caller()
end

---@param source number
---@param item string
---@param count? number
-- TODO: Create a better way without copy pasta
function cfx.inventory.hasItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = function()
			return cfx.inventory.getItemCount(source, item) >= (count or 1)
		end,
		["qb-inventory"] = function()
			return cfx.inventory.getItemCount(source, item) >= (count or 1)
		end
	})

	return caller()
end

return cfx.inventory
