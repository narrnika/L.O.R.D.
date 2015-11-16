local base_scale = 0.05
local dx, dy, dz = 13, 13, 13
local function simple_tree(tree, leaf)
	local schematic = {}
	schematic.size = {x=5, y=6, z=5}
	schematic.data = {}
	for z = 1, 5 do
		for y = 1, 6 do
			for x = 1, 5 do
				if x == 3 and z == 3 and y < 6 then table.insert(schematic.data, {name = tree, param1=255, param2=0})
				elseif y > 3 then table.insert(schematic.data, {name = leaf, param1=255, param2=0})
				else table.insert(schematic.data, {name = "ignore", param1=0, param2=0})
				end
			end
		end
	end
	return schematic
end
local noise = {offset = 0, scale = base_scale*0.1, spread = {x=dx*0.5, y=dy*0.5, z=dz*0.5}, seed = SEED, octaves = 5, persistence = 1}

--= angmar =--
minetest.register_decoration({decoration = "default:dry_shrub",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale*2, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"angmar"},
	place_on = {"lottmapgen:angsnowblock"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:seregon",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"angmar"},
	place_on = {"lottmapgen:angsnowblock"},
	height = 1,
})
-- pine_tree = {lottplants:pinetree, lottplants:pineleaf},
minetest.register_decoration({schematic = simple_tree("lottplants:pinetree", "lottplants:pineleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"angmar"},
	place_on = {"lottmapgen:angsnowblock"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- fir_tree = {lottplants:pinetree, lottplants:firleaf},
minetest.register_decoration({schematic = simple_tree("lottplants:pinetree", "lottplants:firleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"angmar"},
	place_on = {"lottmapgen:angsnowblock"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ angmar_fort
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/angmarfort.mts",
	noise_params = noise,
	biomes = {"angmar"},
	place_on = {"lottmapgen:angsnowblock"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= ironhill =--
minetest.register_decoration({decoration = "default:grass_1",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_2",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_3",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_4",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_5",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	height = 1,
})
-- pine_tree = {lottplants:pinetree, lottplants:pineleaf},
minetest.register_decoration({schematic = simple_tree("lottplants:pinetree", "lottplants:pineleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- fir_tree = {lottplants:pinetree, lottplants:firleaf},
minetest.register_decoration({schematic = simple_tree("lottplants:pinetree", "lottplants:firleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- beech_tree = {default:tree, lottplants:beechleaf},
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:beechleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"ironhill"},
	place_on = {"lottmapgen:ironhill_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})

--= dunland =--
minetest.register_decoration({decoration = "default:grass_1",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_2",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_3",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_4",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_5",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	height = 1,
})
-- apple_tree = {default:tree, default:leaves, default:apple},
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"dunland"},
	place_on = {"lottmapgen:dunland_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})

--= mirkwood =--
-- mirk_tree = {default:jungletree, lottplants:mirkleaf},
minetest.register_decoration({schematic = simple_tree("default:jungletree", "lottplants:mirkleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"mirkwood"},
	place_on = {"lottmapgen:mirkwood_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ mirk_house
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/mirkhouse.mts",
	noise_params = noise,
	biomes = {"mirkwood"},
	place_on = {"lottmapgen:mirkwood_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= fangorn =--
minetest.register_decoration({decoration = "lottplants:berries_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pipeweed_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:potato_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mushroom_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:cabbage_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:barley_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:tomatoes_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:turnips_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:melon_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	height = 1,
})
-- elm_tree = {default:tree, lottplants:elmleaf},
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:elmleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- rowan_tree = {default:tree, lottplants:rowanleaf, lottplants:rowanberry},
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:rowanleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+12, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- birch_tree = {lottplants:birchtree, lottplants:birchleaf},
minetest.register_decoration({schematic = simple_tree("lottplants:birchtree", "lottplants:birchleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+13, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- plum_tree = {default:tree, lottplants:plumleaf, lottplants:plum},
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:plumleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+14, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- apple_tree = {default:tree, default:leaves, default:apple},
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+15, octaves=1},
	biomes = {"fangorn"},
	place_on = {"lottmapgen:fangorn_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})

--= gondor =--
minetest.register_decoration({decoration = "default:grass_1",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_2",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_3",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_4",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_5",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:berries_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pipeweed_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:potato_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mushroom_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:cabbage_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:barley_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+12, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:tomatoes_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+13, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:turnips_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+14, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:melon_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+15, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mallos",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+16, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:athelas",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+17, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	height = 1,
})
-- elm_tree = {default:tree, lottplants:elmleaf}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:elmleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+18, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- white_tree = {default:tree, lottplants:whiteleaf}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:whiteleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+19, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- alder_tree = {lottplants:aldertree, lottplants:alderleaf}
minetest.register_decoration({schematic = simple_tree("lottplants:aldertree", "lottplants:alderleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+20, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- plum_tree = {default:tree, lottplants:plumleaf, lottplants:plum}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:plumleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+21, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- apple_tree = {default:tree, default:leaves, default:apple}
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+22, octaves=1},
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ gondor_fort
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/gondorfort.mts",
	noise_params = noise,
	biomes = {"gondor"},
	place_on = {"lottmapgen:gondor_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= shire =--
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:berries_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pipeweed_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:potato_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mushroom_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:cabbage_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:barley_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:tomatoes_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:turnips_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:melon_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	height = 1,
})
-- plum_tree = {default:tree, lottplants:plumleaf, lottplants:plum}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:plumleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+12, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- apple_tree = {default:tree, default:leaves, default:apple}
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+13, octaves=1},
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ hobbite_hole
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/hobbithole.mts",
	noise_params = noise,
	biomes = {"shire"},
	place_on = {"lottmapgen:shire_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= rohan =--
minetest.register_decoration({decoration = "default:grass_1",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_2",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_3",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_4",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "default:grass_5",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:berries_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pipeweed_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:potato_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mushroom_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:cabbage_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+12, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:barley_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+13, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:tomatoes_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+14, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:turnips_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+15, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:melon_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+16, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pilinehtar",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+17, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	height = 1,
})
-- elm_tree = {default:tree, lottplants:elmleaf}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:elmleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+18, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- plum_tree = {default:tree, lottplants:plumleaf, lottplants:plum}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:plumleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+19, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- apple_tree = {default:tree, default:leaves, default:apple}
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+20, octaves=1},
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ rohan_fort
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/rohanfort.mts",
	noise_params = noise,
	biomes = {"rohan"},
	place_on = {"lottmapgen:rohan_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= lorien =--
minetest.register_decoration({decoration = "lottplants:lorien_grass_1",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:lorien_grass_2",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:lorien_grass_3",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:lorien_grass_4",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:lorien_grass_5",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:elanor",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:niphredil",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:lissuin",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:fireflies",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	height = 1,
})
-- mallorn_tree = {lottplants:mallorntree, lottplants:mallornleaf}
minetest.register_decoration({schematic = simple_tree("lottplants:mallorntree", "lottplants:mallornleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- mallorn_tree_young = {lottplants:mallorntree_young, lottplants:mallornleaf}
minetest.register_decoration({schematic = simple_tree("lottplants:mallorntree_young", "lottplants:mallornleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
--[[ mallorn_house
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/mallornhouse.mts",
	noise_params = noise,
	biomes = {"lorien"},
	place_on = {"lottmapgen:lorien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--

--= ithilien =--
minetest.register_decoration({decoration = "lottplants:eglantive",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:anemones",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:asphodel",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+03, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:iris",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+04, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+05, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:berries_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+06, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:pipeweed_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+07, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:potato_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+08, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:corn_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+09, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:mushroom_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+10, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:cabbage_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+11, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:barley_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+12, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:tomatoes_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+13, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:turnips_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+14, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
minetest.register_decoration({decoration = "lottplants:melon_wild",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+15, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	height = 1,
})
-- elm_tree = {default:tree, lottplants:elmleaf}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:elmleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+16, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- lebethron_tree = {lottplants:lebethrontree, lottplants:lebethronleaf}
minetest.register_decoration({schematic = simple_tree("lottplants:lebethrontree", "lottplants:lebethronleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+17, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- culumalda_tree = {default:tree, lottplants:culumaldaleaf, lottplants:yellowflowers}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:culumaldaleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+18, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- plum_tree = {default:tree, lottplants:plumleaf, lottplants:plum}
minetest.register_decoration({schematic = simple_tree("default:tree", "lottplants:plumleaf"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+19, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})
-- apple_tree = {default:tree, default:leaves, default:apple}
minetest.register_decoration({schematic = simple_tree("default:tree", "default:leaves"),
	deco_type = "schematic",
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+20, octaves=1},
	biomes = {"ithilien"},
	place_on = {"lottmapgen:ithilien_grass"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
})

--= mordor =--
minetest.register_decoration({decoration = "lottplants:brambles_of_mordor",
	deco_type = "simple",
	noise_params = {offset=0, scale=base_scale, spread={x = dx, y = dy, z = dz}, seed=SEED+01, octaves=1},
	biomes = {"mordor"},
	place_on = {"lottmapgen:mordor_stone"},
	height = 1,
})
-- tree = {default:tree}
minetest.register_decoration({
	deco_type = "schematic",
	schematic = {
		size = {x=1, y=5, z=5},
		data = {
			{name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "air", param1=255, param2=0},
			{name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0},
			{name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0},
			{name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0},
			{name = "air", param1=255, param2=0}, {name = "air", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "default:tree", param1=255, param2=0}, {name = "air", param1=255, param2=0},
		},
	},
	noise_params = {offset=0, scale=base_scale*0.5, spread={x = dx, y = dy, z = dz}, seed=SEED+02, octaves=1},
	biomes = {"mordor"},
	place_on = {"lottmapgen:mordor_stone"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})
--[[ orc_fort
minetest.register_decoration({
	deco_type = "schematic",
	schematic = "schems/orcfort.mts",
	noise_params = noise,
	biomes = {"mordor"},
	place_on = {"lottmapgen:mordor_stone"},
	flags = {place_center_x = true, place_center_y = false, place_center_z = true, force_placement = true},
	rotation = "random",
})]]--
