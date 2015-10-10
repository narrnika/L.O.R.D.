torches = {}
torches.enable_ceiling = minetest.setting_getbool("torches_enable_ceiling") or false

local modpath = minetest.get_modpath("torches")

dofile(modpath.."/mt_style.lua")
