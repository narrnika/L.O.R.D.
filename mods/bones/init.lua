local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- Minetest 0.4 mod: bones
-- See README.txt for licensing and other information. 

local publish = tonumber(minetest.setting_get("share_bones_time")) or 60*5

local bones_formspec =
	"size[8,9]"..
	"list[current_name;main;0,0;8,4;]"..
	"list[current_player;main;0,5;8,4;]"..
	"background[-0.5,-0.65;9,10.35;gui_bonesbg.png]"..
	"listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name then
		return true
	end
	return false
end

minetest.register_node("bones:bones", {
	description = SL("Corpse"),
	drawtype = "mesh",
	mesh = "bones.obj",
	tiles = {"character.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.7, 0.3, -0.2, 0.7},
	},
	paramtype2 = "facedir",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
	
	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return is_owner(pos, player:get_player_name()) and inv:is_empty("main")
	end,
	
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,
	
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return 0
	end,
	
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,
	
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") ~= "" and meta:get_inventory():is_empty("main") then
			meta:set_string("infotext", SL("Unknown corpse"))
			meta:set_string("owner", "")
		end
	end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		meta:set_string("infotext", SL("Unknown corpse"))
		meta:set_string("formspec", bones_formspec)
	end,

	on_timer = function(pos, elapsed)
		if publish <= 0 then return false end -- таймер не работает
		local meta = minetest.get_meta(pos)
		local time = meta:get_int("time") + elapsed
		if time >= publish then
			meta:set_string("infotext", SL("Unknown corpse"))
			meta:set_string("owner", "")
			return false
		else
			meta:set_int("time", time)
			return true
		end
	end,
	
	on_punch = function(pos, node, player)
		if(not is_owner(pos, player:get_player_name())) then
			return
		end
		
		local inv = minetest.get_meta(pos):get_inventory()
		local player_inv = player:get_inventory()
		local has_space = true
		
		for i=1,inv:get_size("main") do
			local stk = inv:get_stack("main", i)
			if player_inv:room_for_item("main", stk) then
				inv:set_stack("main", i, nil)
				player_inv:add_item("main", stk)
			else
				has_space = false
				break
			end
		end
	end
})

minetest.register_on_dieplayer(function(player)
	if minetest.setting_getbool("creative_mode") then return end
	
	local pos = player:getpos()
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+0.5)
	pos.z = math.floor(pos.z+0.5)
	
	if minetest.get_node(pos).name ~= "air" then
		local new_pos = minetest.find_node_near(pos, 5*3, "air")
		if new_pos then
			pos = new_pos
		else
			return
		end
	end
	
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	local nn = minetest.get_node(pos).name
	if minetest.registered_nodes[nn].can_dig and not minetest.registered_nodes[nn].can_dig(pos, player) then
		local player_inv = player:get_inventory()
		for i=1,player_inv:get_size("main") do
			player_inv:set_stack("main", i, nil)
		end
		for i=1,player_inv:get_size("craft") do
			player_inv:set_stack("craft", i, nil)
		end
		return
	end
	minetest.dig_node(pos)
	minetest.add_node(pos, {name="bones:bones", param2=param2})
	
	
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local player_inv = player:get_inventory()
	inv:set_size("main", 8*4)
	local empty_list = inv:get_list("main")
	inv:set_list("main", player_inv:get_list("main"))
	player_inv:set_list("main", empty_list)
	for i = 1, player_inv:get_size("craft") do
		inv:add_item("main", player_inv:get_stack("craft", i))
		player_inv:set_stack("craft", i, nil)
	end
	meta:set_string("formspec",bones_formspec)
	if publish < 0 then -- все трупы - достояние общественности
		meta:set_string("infotext", SL("Unknown corpse"))
		meta:set_string("owner", "")
	elseif publish == 0 then -- труп - собственность хозяина - навсегда
		meta:set_string("infotext", SL("Corpse of").." "..player:get_player_name())
		meta:set_string("owner", player:get_player_name())
	else -- труп - собственность хозяина - на время publish
		meta:set_string("infotext", SL("Corpse of").." "..player:get_player_name())
		meta:set_string("owner", player:get_player_name())
		meta:set_int("time", 0)
		minetest.get_node_timer(pos):start(10)
	end
end)

dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."items.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."skeleton.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."crafting.lua")

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
