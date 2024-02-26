cfx.caller = {}

ESX = nil

local cachedFramework = nil
local cachedInventory = nil
local cachedTarget = nil

---@type { [Framework]: string }
local frameworkResourceMap = {
	["ESX"] = "es_extended",
	["QB"] = "qb-core"
}

---@type { [TargetSystem]: string }
local targetResourceMap = {
	["ox_target"] = "ox_target",
	["qb_target"] = "qb_target",
	["qtarget"] = "qtarget"
}

---@type { [TargetSystem]: string }
local inventoryResourceMap = {
	["ox_inventory"] = "ox_inventory",
	["qb-inventory"] = "qb-inventory",
}

---@generic TSystem
---@param system TSystem
---@return TSystem
function cfx.caller.getSystem(system, map)
	if system ~= "auto" then
		local resourceName = map[system]
		if not cfx.caller.isResourceStarted(resourceName) then
			error(("Resource '%s' is not started"):format(system))
		end

		return system
	end

	for system, resourceName in pairs(map) do
		if cfx.caller.isResourceStarted(resourceName) then
			if resourceName == "qtarget" and cfx.caller.isResourceStarted("ox_target") then
				return "ox_target"
			end

			return system
		end
	end

	return nil
end

function cfx.caller.getFramework()
	if cachedFramework then
		return cachedFramework
	end

	---@type Framework
	local framework = cfx.caller.getSystem(SharedConfig.framework, frameworkResourceMap)
	cfx.caller.initializeFramework(framework)

	return framework
end

function cfx.caller.getTarget()
	if cachedTarget then
		return cachedTarget
	end

	local target = cfx.caller.getSystem(SharedConfig.target, targetResourceMap)
	cachedTarget = target

	return target
end

function cfx.caller.getInventory()
	if cachedInventory then
		return cachedInventory
	end

	---@type InventorySystem
	local inventory = cfx.caller.getSystem(SharedConfig.inventory, inventoryResourceMap)
	cachedInventory = inventory

	return inventory
end

---@param framework Framework
function cfx.caller.initializeFramework(framework)
	cachedFramework = framework

	local resourceName = frameworkResourceMap[framework]
	if framework == "ESX" then
		ESX = exports[resourceName]:getSharedObject()
	elseif framework == "QB" then
		QB = exports[resourceName]:GetCoreObject()

		local context = IsDuplicityVersion() and "server" or "client"
		RegisterNetEvent(("QBCore:%s:UpdateObject"):format(context), function()
			QB = exports[resourceName]:GetCoreObject()
		end)
	end
end

function cfx.caller.isResourceStarted(resourceName)
	local state = GetResourceState(resourceName)
	return state == "started" or state == "starting"
end

---@generic TFunc : function
---@param functions { [Framework]: TFunc }
---@return TFunc
function cfx.caller.createFrameworkCaller(functions)
	local framework = cfx.caller.getFramework()
	for targetFramework, targetFunc in pairs(functions) do
		if targetFramework == framework then
			return targetFunc
		end
	end

	return error(("Framework '%s' is not supported"):format(framework))
end

---@generic TFunc : function
---@param functions { [InventorySystem]: TFunc }
---@return TFunc
function cfx.caller.createInventoryCaller(functions)
	local inventory = cfx.caller.getInventory()
	local func = nil

	for targetInventory, targetFunc in pairs(functions) do
		if targetInventory == inventory then
			func = targetFunc
			break
		end
	end

	if func == nil then
		error(("Inventory '%s' is not supported"):format(inventory))
	end

	return func
end

return cfx.caller
