local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_node("bones:skeleton", {
	description = SL("Skeleton Head"),
	 drawtype = "nodebox",
	tiles = {
		"bones_skeleton_top.png",
		"bones_skeleton_bottom.png",
		"bones_skeleton_side.png",
		"bones_skeleton_side.png",
		"bones_skeleton_rear.png",
		"bones_skeleton_front.png"
	},
	paramtype2 = "facedir",
	 paramtype = "light",
	groups = {dig_immediate=2},
	 drop = "bones:bonedust",
	 node_box = {
		type = "fixed",
		fixed = {
			{-0.3125,0.3125,-0.3125,0.3125,0.5,0.3125},
			{ -0.5,0.25,-0.5,0.5,0.415385,0.5},
			{-0.5,-0.1875,-0.5,0.5,0.375,0.5}, 
			{-0.375,-0.5,-0.3125,0.375,0.125,0.3125}, 
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("bones:skeleton_body", {
	description = SL("Skeleton"),
	drawtype = "nodebox",
	tiles = {"bones_skeleton_top.png"},
	inventory_image = "bones_skeleton.png",
	wield_image = "bones_skeleton.png",
	paramtype = "light",
	groups = {dig_immediate=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625,-0.0625,-0.0625,0.125,0.5,0.0625},
			{-0.25,-0.3125,-0.25,0.3125,-0.0625,0.25},
			{-0.25,-0.5,-0.0625,-0.125,-0.0625,0.125},
			{0.3125,-0.5,-0.0625,0.1875,-0.0625,0.125},
			{-0.3125,0,-0.375,0.375,0.125,0.375},
			{-0.3125,0.375,-0.375,0.375,0.5,0.375},
			{-0.3125,0.1875,-0.375,0.375,0.3125,0.375},
			   		{0.375,-0.0625,-0.0625,0.5,0.5,0.1875},
			   		{-0.3125,-0.0625,-0.0625,-0.4375,0.5,0.1875},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
	on_place = function(itemstack, placer, pointed_thing)
			local above = pointed_thing.above
		if minetest.env:get_node({x = above.x, y = above.y + 1, z = above.z}).name ~= "air" then
			return itemstack
		end
		local fdir = 0
		local placer_pos = placer:getpos()
		if placer_pos then
			dir = {
				x = above.x - placer_pos.x,
				y = above.y - placer_pos.y,
				z = above.z - placer_pos.z
			}
			fdir = minetest.dir_to_facedir(dir)
		end
		minetest.env:add_node(above, {name = "bones:skeleton_body", param2 = fdir})
		minetest.env:add_node({x = above.x, y = above.y + 1, z = above.z}, {name = "bones:skeleton", param2 = fdir})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
	on_destruct = function(pos)
			local p = {x=pos.x, y=pos.y+1, z=pos.z}
		minetest.env:remove_node(p)
	end
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
