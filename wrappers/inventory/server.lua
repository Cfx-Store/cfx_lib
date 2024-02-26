cfx.inventory = {}

-------------
-- addItem --
-------------

local function addItem_ox(source, item, count)
	exports.ox_inventory:AddItem(source, item, count)
end

---@param source number
---@param item string
---@param count? number
function cfx.inventory.addItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = addItem_ox,
	})

	return caller(source, item, count or 1)
end

----------------
-- removeItem --
----------------

local function removeItem_ox(source, item, count)
	exports.ox_inventory:RemoveItem(source, item, count)
end

---@param source number
---@param item string
---@param count? number
function cfx.inventory.removeItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = removeItem_ox,
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

---@param source number
---@param item string
function cfx.inventory.getItemCount(source, item)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = getItemCount_ox,
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

---@param source number
---@param item string
---@param count? number
function cfx.inventory.hasItem(source, item, count)
	local caller = cfx.caller.createInventoryCaller({
		["ox_inventory"] = hasItem_ox,
	})

	return caller(source, item, count or 1)
end

return cfx.inventory
