local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_craftitem("lottmobs:meat", {
	description = SL("Cooked Meat"),
	inventory_image = "lottmobs_meat.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("lottmobs:meat_raw", {
	description = SL("Raw Meat"),
	inventory_image = "lottmobs_meat_raw.png",
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:meat",
	recipe = "lottmobs:meat_raw",
})

minetest.register_craftitem("lottmobs:dirty_shirt", {
    description = SL("Dirty Jacket"),
    inventory_image = "lottclothes_inv_jacket_midgewater.png^[colorize:#935d3675",
    stack_max = 1,
})

minetest.register_craftitem("lottmobs:dirty_trousers", {
    description = SL("Dirty Trousers"),
    inventory_image = "lottclothes_inv_pants_midgewater.png^[colorize:#935d3675",
    stack_max = 1,
})

minetest.register_craft({
    output = "lottclothes:jacket_midgewater",
    type = "shapeless",
    recipe = {"bucket:bucket_water", "lottmobs:dirty_shirt"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craft({
    output = "lottclothes:pants_midgewater",
    type = "shapeless",
    recipe = {"bucket:bucket_water", "lottmobs:dirty_trousers"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})
