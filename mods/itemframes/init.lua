local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- See README.txt for licensing and other information.

local tmp = {}
itemframes = {}

minetest.register_entity("itemframes:item",{
	hp_max = 1,
	visual="wielditem",
	visual_size={x=.33,y=.33},
	collisionbox = {0,0,0,0,0,0},
	physical=false,
	textures={"air"},
	on_activate = function(self, staticdata)
		if tmp.nodename ~= nil and tmp.texture ~= nil then
			self.nodename = tmp.nodename
			tmp.nodename = nil
			self.texture = tmp.texture
			tmp.texture = nil
		else
			if staticdata ~= nil and staticdata ~= "" then
				local data = staticdata:split(';')
				if data and data[1] and data[2] then
					self.nodename = data[1]
					self.texture = data[2]
				end
			end
		end
		if self.texture ~= nil then
			self.object:set_properties({textures={self.texture}})
		end
		if self.nodename ~= "itemframes:frame" then
			self.object:set_properties({automatic_rotate=1})
		end
	end,
	get_staticdata = function(self)
		if self.nodename ~= nil and self.texture ~= nil then
			return self.nodename .. ';' .. self.texture
		end
		return ""
	end,
})

local facedir = {}
facedir[0] = {x=0,y=0,z=1}
facedir[1] = {x=1,y=0,z=0}
facedir[2] = {x=0,y=0,z=-1}
facedir[3] = {x=-1,y=0,z=0}

local remove_item = function(pos, node)
	local objs = nil
	if node.name == "itemframes:frame" then
		objs = minetest.env:get_objects_inside_radius(pos, .5)
	elseif minetest.get_item_group(node.name, "group:pedestal") then
		objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y+1,z=pos.z}, .5)
	end
	if objs then
		for _, obj in ipairs(objs) do
			if obj and obj:get_luaentity() and obj:get_luaentity().name == "itemframes:item" then
				obj:remove()
			end
		end
	end
end

local update_item = function(pos, node)
	remove_item(pos, node)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("item") ~= "" then
		if node.name == "itemframes:frame" then
			local posad = facedir[node.param2]
			if not posad then return end
			pos.x = pos.x + posad.x*6.5/16
			pos.y = pos.y + posad.y*6.5/16
			pos.z = pos.z + posad.z*6.5/16
		elseif minetest.get_item_group(node.name, "group:pedestal") then
			pos.y = pos.y + 12/16+.33
		end
		tmp.nodename = node.name
		tmp.texture = ItemStack(meta:get_string("item")):get_name()
		local e = minetest.env:add_entity(pos,"itemframes:item")
		if node.name == "itemframes:frame" then
			local yaw = math.pi*2 - node.param2 * math.pi/2
			e:setyaw(yaw)
		end
	end
end

local drop_item = function(pos, node)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("item") ~= "" then
		if node.name == "itemframes:frame" then
			minetest.env:add_item(pos, meta:get_string("item"))
		elseif minetest.get_item_group(node.name, "group:pedestal") then
			minetest.env:add_item({x=pos.x,y=pos.y+1,z=pos.z}, meta:get_string("item"))
		end
		meta:set_string("item","")
	end
	remove_item(pos, node)
end

minetest.register_node("itemframes:frame",{
	description = SL("Item frame"),
	drawtype = "nodebox",
	node_box = { type = "fixed", fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5} },
	selection_box = { type = "fixed", fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5} },
	tiles = {"itemframes_frame.png"},
	inventory_image = "itemframes_frame.png",
	wield_image = "itemframes_frame.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = { choppy=2,dig_immediate=2 },
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",placer:get_player_name())
		meta:set_string("infotext", SL("Item frame (owned by").." "..placer:get_player_name()..")")
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		if not itemstack then return end
		local meta = minetest.env:get_meta(pos)
		if clicker:get_player_name() == meta:get_string("owner") then
			drop_item(pos,node)
			local s = itemstack:take_item()
			meta:set_string("item",s:to_string())
			update_item(pos,node)
		end
		return itemstack
	end,
	on_punch = function(pos,node,puncher)
		local meta = minetest.env:get_meta(pos)
		if puncher:get_player_name() == meta:get_string("owner") then
			drop_item(pos, node)
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		return player:get_player_name() == meta:get_string("owner")
	end,
})

minetest.register_craft({
	output = 'itemframes:frame',
	recipe = {
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', 'default:paper', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
	}
})

function itemframes.register_pedestal(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node("itemframes:pedestal_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		node_box = { type = "fixed", fixed = {
			{-7/16, -8/16, -7/16, 7/16, -7/16, 7/16}, -- bottom plate
			{-6/16, -7/16, -6/16, 6/16, -6/16, 6/16}, -- bottom plate (upper)
			{-0.25, -6/16, -0.25, 0.25, 11/16, 0.25}, -- pillar
			{-7/16, 11/16, -7/16, 7/16, 12/16, 7/16}, -- top plate
		}},
		groups = groups,
		sounds = sounds,
		paramtype = "light",
		after_place_node = function(pos, placer, itemstack)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("owner",placer:get_player_name())
			meta:set_string("infotext", SL("Pedestal (owned by").." "..placer:get_player_name()..")")
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			if not itemstack then return end
			local meta = minetest.env:get_meta(pos)
			if clicker:get_player_name() == meta:get_string("owner") then
				drop_item(pos,node)
				local s = itemstack:take_item()
				meta:set_string("item",s:to_string())
				update_item(pos,node)
			end
			return itemstack
		end,
		on_punch = function(pos,node,puncher)
			local meta = minetest.env:get_meta(pos)
			if puncher:get_player_name() == meta:get_string("owner") then
				drop_item(pos,node)
			end
		end,
		can_dig = function(pos,player)
			local meta = minetest.env:get_meta(pos)
			return player:get_player_name() == meta:get_string("owner")
		end,
	})

	minetest.register_craft({
		output = 'itemframes:pedestal_' .. subname,
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{'', recipeitem, ''},
			{recipeitem, recipeitem, recipeitem},
		}
	})
end

itemframes.register_pedestal("wood", "default:wood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3,pedestal=1},
		{"default_wood.png"},
		SL("Wooden Pedestal"),
		default.node_sound_wood_defaults()
)

itemframes.register_pedestal("stone", "default:stone",
		{cracky=3,pedestal=1},
		{"default_stone.png"},
		SL("Stone Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("cobble", "default:cobble",
		{cracky=3,pedestal=1},
		{"default_cobble.png"},
		SL("Cobblestone Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("desert_stone", "default:desert_stone",
		{cracky=3,pedestal=1},
		{"default_desert_stone.png"},
		SL("Desert Stone Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("desert_cobble", "default:desert_cobble",
		{cracky=3,pedestal=1},
		{"default_desert_cobble.png"},
		SL("Desert Cobblestone Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("desert_stonebrick", "default:desert_stonebrick",
		{cracky=3,pedestal=1},
		{"default_desert_stone_brick.png"},
		SL("Desert Stone Brick Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("brick", "default:brick",
		{cracky=3,pedestal=1},
		{"default_brick.png"},
		SL("Brick Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("sandstone", "default:sandstone",
		{crumbly=2,cracky=2,pedestal=1},
		{"default_sandstone.png"},
		SL("Sandstone Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("sandstonebrick", "default:sandstonebrick",
		{crumbly=2,cracky=2,pedestal=1},
		{"default_sandstone_brick.png"},
		SL("Sandstone Brick Pedestal"),
		default.node_sound_stone_defaults()
)

itemframes.register_pedestal("stonebrick", "default:stonebrick",
		{cracky=3,pedestal=1},
		{"default_stone_brick.png"},
		SL("Stone Brick Pedestal"),
		default.node_sound_stone_defaults()
)

-- automatically restore entities lost from
-- frames/pedestals due to /clearobjects or similar

minetest.register_abm({
	nodenames = {"itemframes:frame", "group:pedestal"},
	interval = 15,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if #minetest.get_objects_inside_radius(pos, 0.5) > 0 then return end
		update_item(pos, node)
	end
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end