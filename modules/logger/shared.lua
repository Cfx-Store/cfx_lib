local levels = {
	"^1[ERROR]",
	"^3[WARN]",
	"^7[INFO]",
	"^6[DEBUG]",
}

local function log(level, ...)
	-- if level > SharedConfig.logLevel then
	-- 	return
	-- end

	local args = { ... }
	for i = 1, #args do
		local arg = args[i]
		args[i] = type(arg) == 'table' and json.encode(arg, {
			sort_keys = true,
			indent = true
		}) or tostring(arg)
	end

	print(("^8[%s] %s %s^7"):format(cfx.cache.resource, levels[level], table.concat(args, " ")))
end

cfx.logger = {
	error = function(...) log(1, ...) end,
	warn = function(...) log(2, ...) end,
	info = function(...) log(3, ...) end,
	debug = function(...) log(4, ...) end,
}

return cfx.logger
