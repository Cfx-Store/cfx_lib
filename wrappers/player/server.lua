cfx.player = {}

---@param source number|string
function cfx.player.getIdentifierFromSource(source)
	local identifier = GetPlayerIdentifierByType(tostring(source), SharedConfig.primaryIdentifier or "license")
	return identifier
end

local function getFromId_ESX(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	return xPlayer
end

function cfx.player.getFromId(source)
	local caller = cfx.caller.createFrameworkCaller({
		["ESX"] = getFromId_ESX
	})

	local player = caller(source)
	return player
end

return cfx.player
