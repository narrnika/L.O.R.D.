minetest.register_alias("mapgen_stone",					"default:stone")
minetest.register_alias("mapgen_water_source",			"default:water_source")
minetest.register_alias("mapgen_river_water_source",	"default:water_source")
minetest.register_alias("mapgen_lava_source",			"default:lava_source")

SEED = 0

minetest.register_on_mapgen_init(function(mgparams)
	local new_mgparams = mgparams
	new_mgparams.mgname = "v7"
--	new_mgparams.seed = "narrnika"
	new_mgparams.flags = "notrees, caves, nodungeons, noflat, light"
	minetest.set_mapgen_params(new_mgparams)
	SEED = new_mgparams.seed
end)

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
