minetest.register_biome({name = "angmar",
	node_dust = "air", node_top = "lottmapgen:angsnowblock", node_filler = "default:stone",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:ice", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = -10, humidity_point = 50,
})


minetest.register_biome({name = "ironhill",
	node_dust = "air", node_top = "lottmapgen:ironhill_grass", node_filler = "default:stone",
	depth_top = 1, depth_filler = 40,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 20, humidity_point = 20,
})

minetest.register_biome({name = "dunland",
	node_dust = "air", node_top = "lottmapgen:dunland_grass", node_filler = "default:desert_stone",
	depth_top = 1, depth_filler = 100,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 20, humidity_point = 50,
})

minetest.register_biome({name = "mirkwood",
	node_dust = "air", node_top = "lottmapgen:mirkwood_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 20, humidity_point = 80,
})


minetest.register_biome({name = "fangorn",
	node_dust = "air", node_top = "lottmapgen:fangorn_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 50, humidity_point = 20,
})

minetest.register_biome({name = "gondor",
	node_dust = "air", node_top = "lottmapgen:gondor_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 50, humidity_point = 50,
})

minetest.register_biome({name = "shire",
	node_dust = "air", node_top = "lottmapgen:shire_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 50, humidity_point = 80,
})


minetest.register_biome({name = "rohan",
	node_dust = "air", node_top = "lottmapgen:rohan_grass", node_filler = "default:desert_stone",
	depth_top = 1, depth_filler = 50,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 80, humidity_point = 20,
})

minetest.register_biome({name = "lorien",
	node_dust = "air", node_top = "lottmapgen:lorien_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 80, humidity_point = 50,
})

minetest.register_biome({name = "ithilien",
	node_dust = "air", node_top = "lottmapgen:ithilien_grass", node_filler = "default:dirt",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 80, humidity_point = 80,
})


minetest.register_biome({name = "mordor",
	node_dust = "air", node_top = "lottmapgen:mordor_stone", node_filler = "lottmapgen:mordor_stone",
	depth_top = 1, depth_filler = 50,

	node_dust_water = "air", node_water_top = "default:blacksource", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = 1, y_max = 75,
	heat_point = 110, humidity_point = 50,
})



minetest.register_biome({name = "bottom_hold",
	node_dust = "air", node_top = "default:stone", node_filler = "default:stone",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:ice", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = -25, y_max = 0,
	heat_point = -15, humidity_point = 50,
})

minetest.register_biome({name = "bottom_medium",
	node_dust = "air", node_top = "default:sand", node_filler = "default:stone",
	depth_top = 1, depth_filler = 3,

	node_dust_water = "air", node_water_top = "default:water_source", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = -25, y_max = 0,
	heat_point = 50, humidity_point = 50,
})

minetest.register_biome({name = "bottom_hot",
	node_dust = "air", node_top = "lottmapgen:mordor_stone", node_filler = "lottmapgen:mordor_stone",
	depth_top = 1, depth_filler = 30,

	node_dust_water = "air", node_water_top = "default:blacksource", node_water = "default:water_source",
	depth_water_top = 1,

	y_min = -25, y_max = 0,
	heat_point = 115, humidity_point = 50,
})



minetest.register_biome({name = "top_hold",
	node_dust = "default:snow", node_top = "default:snowblock", node_filler = "lottmapgen:frozen_stone",
	depth_top = 1, depth_filler = 3,

	y_min = 75, y_max = 125,
	heat_point = -15, humidity_point = 50,
})

minetest.register_biome({name = "top_medium",
	node_dust = "default:snow", node_top = "default:dirt_with_snow", node_filler = "default:stone",
	depth_top = 1, depth_filler = 3,

	y_min = 75, y_max = 125,
	heat_point = 50, humidity_point = 50,
})

minetest.register_biome({name = "top_hot",
	node_dust = "default:snow", node_top = "lottmapgen:mordor_stone", node_filler = "lottmapgen:mordor_stone",
	depth_top = 1, depth_filler = 30,

	y_min = 75, y_max = 125,
	heat_point = 115, humidity_point = 50,
})



minetest.register_biome({name = "peak",
	node_dust = "default:ice", node_top = "lottmapgen:frozen_stone", node_filler = "lottmapgen:frozen_stone",
	depth_top = 1, depth_filler = 30,

	y_min = 125, y_max = 200,
	heat_point = 50, humidity_point = 50,
})
