LIGHTSPEED = SMODS.current_mod
assert(SMODS.current_mod.lovely, "Lovely patches were not loaded! Make sure your mod is in the right place.")

LIGHTSPEED.mod_path = SMODS.current_mod.path .. ""

local function load_file(path, ...)
	local f, err = SMODS.load_file(path)
	if err then error(err) end
	return f(...)
end

function LIGHTSPEED.load_module(mod)
	local f, err, path_prefix
	if LIGHTSPEED.current_module == nil then
		path_prefix = ""
	else
		path_prefix = LIGHTSPEED.current_module .. "/"
	end
	if NFS.getInfo(LIGHTSPEED.mod_path .. "/" .. path_prefix .. mod .. "/mod.lua") ~= nil then
		print("[LIGHTSPEED] Loading module " .. path_prefix .. mod .. "/mod.lua...")
		f, err = SMODS.load_file(path_prefix .. mod .. "/mod.lua")
	else
		print("[LIGHTSPEED] Loading module " .. path_prefix .. mod .. ".lua...")
		f, err = SMODS.load_file(path_prefix .. mod .. ".lua")
	end
	if err then error(err) end
	local old_mod = LIGHTSPEED.current_module
	LIGHTSPEED.current_module = path_prefix .. mod
	local res = f()
	LIGHTSPEED.current_module = old_mod
	print("[LIGHTSPEED] Loaded module " .. path_prefix .. mod)
	return res
end

LIGHTSPEED.current_module = nil

LIGHTSPEED.load_module "src"
