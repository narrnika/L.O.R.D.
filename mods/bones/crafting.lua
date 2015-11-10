minetest.register_craft({
	type = "fuel",
	recipe = "bones:bonedust",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "bones:bone",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "bones:bones",
	burntime = 36,
})

minetest.register_craft({
	output = 'bones:bone 9',
	recipe = {
		{'bones:bones'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "bones:bonedust",
	recipe = "bones:bone",
})

minetest.register_craft({
	output = 'bones:bone_scythe',
	recipe = {
		{'bones:bone', 'bones:bone', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick',''},
	}
})

minetest.register_craft({
	output = 'bones:skeleton_body',
	recipe = {
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
	}
})

