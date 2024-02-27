cfx.inventory = {}

-------------
-- addItem --
-------------
local function addItem_ox(source, item, count)
	exports.ox_inventory:AddItem(source, item, count)
end

local function addItem_esx(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem(item, count)
end

local function addItem_qb(source, item, count)
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.AddItem(item, count)
end


---@param source number
---@param item string
---@param count? number
function cfx.inventory.addItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = addItem_ox,
		["es_extended"] = addItem_esx,
		["qb-core"] = addItem_qb,
	})

	return caller(source, item, count or 1)
end

----------------
-- removeItem --
----------------
local function removeItem_ox(source, item, count)
	exports.ox_inventory:RemoveItem(source, item, count)
end

local function removeItem_qb(source, item, count)
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.RemoveItem(item, count)
end

local function removeItem_esx(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem(item, count)
end


---@param source number
---@param item string
---@param count? number
function cfx.inventory.removeItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = removeItem_ox,
		["es_extended"] = removeItem_esx,
		["qb-core"] = removeItem_qb,
	})

	return caller(source, item, count or 1)
end

------------------
-- getItemCount --
------------------

local function getItemCount_ox(source, item)
	local result = exports.ox_inventory:Search(source, 'count', item)
	return result
end

local function getItemCount_esx(source, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = xPlayer.getInventoryItem(item).count
	
	return result
end

local function getItemCount_qb(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	local result = Player.Functions.GetItemByName(item)

	if not result then 
		return 0
	end

	return result.amount
end

---@param source number
---@param item string
function cfx.inventory.getItemCount(source, item)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = getItemCount_ox,
		["es_extended"] = getItemCount_esx,
		["qb-core"] = getItemCount_qb,
	})

	return caller(source, item)
end

-------------
-- hasItem --
-------------

local function hasItem_ox(source, item, count)
	local result = cfx.inventory.getItemCount(source, item)
	return result >= count
end

local function hasItem_esx(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = xPlayer.getInventoryItem(item)

	if not result then 
		return false
	end
	
	return result.count >= count
end

local function hasItem_qb(source, item, count)
	local Player = QBCore.Functions.GetPlayer(source)
	local result = Player.Functions.GetItemByName(item)
	
	if not result then 
		return false
	end

	return result.amount >= count
end


---@param source number
---@param item string
---@param count? number
function cfx.inventory.hasItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = hasItem_ox,
		["es_extended"] = hasItem_esx,
		["qb-core"] = hasItem_qb,
	})

	return caller(source, item, count or 1)
end

return cfx.inventory
