cfx = {}

cfx.cache = {}
cfx.cache.resource = GetCurrentResourceName()

function cfx:new()
	setmetatable({}, self)
	self.__index = self

	return self
end

exports("getLib", function()
	return cfx:new()
end)
