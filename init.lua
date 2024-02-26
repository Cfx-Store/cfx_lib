local resourceName = GetCurrentResourceName()
local context = IsDuplicityVersion() and "server" or "client"
local export = exports["cfx_lib"]

local function loadResourceFile(root, module)
	local dir = ("%s/%s"):format(root, module)
	local chunk = LoadResourceFile("cfx_lib", ("%s/%s.lua"):format(dir, context))
	local shared = LoadResourceFile("cfx_lib", ("%s/shared.lua"):format(dir))

	return root, chunk, shared
end

local function loadConfig()
	local sharedConfig = LoadResourceFile("cfx_lib", "configs/shared.lua")
	return sharedConfig
end

local function loadModule(self, module)
	local dir, chunk, shared = loadResourceFile("modules", module)
	if not chunk and not shared then
		dir, chunk, shared = loadResourceFile("wrappers", module)
	end

	local sharedConfig = loadConfig()
	if shared then
		chunk = (chunk and ("%s\n%s"):format(shared, chunk)) or shared
	end

	if sharedConfig then
		chunk = ("%s\n%s"):format(sharedConfig, chunk)
	end

	if chunk then
		local fn, err = load(chunk, ("@@cfx_lib/%s/%s/%s.lua"):format(dir, module, context))
		if not fn or err then
			return error(("Failed to load module %s: %s"):format(module, err))
		end

		local result = fn()
		self[module] = result

		return self[module]
	end
end

local function call(self, index, ...)
	local module = rawget(self, index)
	if not module then
		self[index] = noop
		module = loadModule(self, index)

		if not module then
			local function method(...)
				return export[index](nil, ...)
			end

			if not ... then
				self[index] = method
			end

			return method
		end
	end

	return module
end

local cfx = setmetatable({
	name = "cfx_lib",
	-- TODO: Fix this
	cache = {
		resource = resourceName
	}
}, {
	__index = call,
	__call = call
})

_ENV.cfx = cfx
require = cfx.require
