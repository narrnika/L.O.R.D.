local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}

beds.formspec = "size[8,15;true]"..
		"bgcolor[#080808BB; true]"..
		"button_exit[2,12;4,0.75;leave;"..SL("Leave Bed").."]"

local modpath = minetest.get_modpath("beds")

-- load files
dofile(modpath.."/functions.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/beds.lua")
dofile(modpath.."/spawns.lua")

print(minetest.get_current_modname().." LOADED")
