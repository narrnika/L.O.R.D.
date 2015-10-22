local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local function get_output_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"..
		"list[nodemeta:".. spos .. ";main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

local function get_input_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"..
		"list[nodemeta:".. spos .. ";drop;3.5,2;1,1;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

minetest.register_node("lord_mail:mail_chest", {
	description = SL("Mail Chest"),
	tiles = {"mail_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy=2,oddly_breakable_by_hand=2,wooden=1},
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", SL("Mail for").." "..owner)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_size("drop", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local player = clicker:get_player_name()
		local owner  = meta:get_string("owner")
		local meta = minetest.get_meta(pos)
		if owner == player then
			minetest.show_formspec(
				clicker:get_player_name(),
				"lord_mail:mail_chest_output",
				get_output_formspec(pos))
		else
			minetest.show_formspec(
				clicker:get_player_name(),
				"lord_mail:mail_chest_input",
				get_input_formspec(pos))
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		return player:get_player_name() == owner and inv:is_empty("main")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "drop" and inv:room_for_item("main", stack) then
			inv:remove_item("drop", stack)
			inv:add_item("main", stack)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "main" then
			return 0
		end
		if listname == "drop" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:room_for_item("main", stack) then
				return -1
			else
				return 0
			end
		end
	end,
})

minetest.register_craft({output = "lord_mail:mail_chest",
	recipe = {{"default:chest_locked"}},
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
