---@param source number|string
function cfx.getIdentifierFromSource(source)
	local identifier = GetPlayerIdentifierByType(tostring(source), SharedConfig.primaryIdentifier or "license")
	return identifier
end

local function getPlayerFromId_ESX(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	return xPlayer
end

function cfx.getPlayerFromId(source)
	local caller = cfx.caller.createFrameworkCaller({
		["ESX"] = getPlayerFromId_ESX
	})

	local player = caller(source)
	return player
end
