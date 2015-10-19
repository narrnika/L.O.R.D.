local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- используемые файлы в каталоге мира
local info_file = minetest.get_worldpath() .. "/info.txt"
local news_file = minetest.get_worldpath() .. "/news.txt"

-- дополнительные привилегии (так же используется give)
minetest.register_privilege("info", {
	description = SL("Can edit news"),
	give_to_singleplayer = false,
})
minetest.register_privilege("news", {
	description = SL("Can edit info"),
	give_to_singleplayer = false,
})

-- размер и фон формы
local form_prop = "size[8,8.5]background[5,5;1,1;gui_formbg.png;true]"

-- чтение/запись txt файлов
local function read_info()
	local input = io.open(info_file, "r")
	local info_text
	if input then
		info_text = input:read("*a")
		io.close(input)
	else
		info_text = SL("info_text")
	end
	return info_text
end
local function write_info(info_text)
	local output = io.open(info_file, "w")
	output:write(info_text)
	io.close(output)
end

local function read_news()
	local input = io.open(news_file, "r")
	local news_text
	if input then
		news_text = input:read("*a")
		io.close(input)
	else
		news_text = SL("news_text")
	end
	return news_text
end
local function write_news(news_text)
	local output = io.open(news_file, "w")
	output:write(news_text)
	io.close(output)
end

-- описание форм
local function info_form(name)
	local privs = minetest.get_player_privs(name)
	local form = form_prop
	if privs["give"] then
		form = form..
			"button[0.3,0;2.5,1;btn_news;"..SL("News").."]"..
			"button[2.75,0;2.5,1;btn_list;"..SL("List").."]"..
			"button[5.2,0;2.5,1;btn_help;"..SL("Help").."]"
	else
		form = form..
			"button[0.3,0;2.5,1;btn_news;"..SL("News").."]"..
			"button[5.2,0;2.5,1;btn_help;"..SL("Help").."]"
	end
	form = form.."label[0.3,1.0;"..SL("Admin:").." "..minetest.setting_get("name").."]" --admin
	if minetest.setting_getbool("enable_pvp") then --pvp
		form = form.."label[0.3,1.5;"..SL("PvP:").." "..SL("On").."]"
	else
		form = form.."label[0.3,1.5;"..SL("PvP:").." "..SL("Off").."]"
	end
	if minetest.setting_getbool("enable_damage") then --урон
		form = form.."label[0.3,2.0;"..SL("Damage:").." "..SL("On").."]"
	else
		form = form.."label[0.3,2.0;"..SL("Damage:").." "..SL("Off").."]"
	end
	form = form.."label[0.3,2.5;"..SL("Default privileges:").." "..minetest.setting_get("default_privs").."]" --базовые права
	form = form.."textarea[0.6,3.5;7.4,4.83;txt_info;"..SL("Info:")..";"..read_info().."]"
	if privs["info"] then
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]button[4.7,7.7;3,1;btn_save;"..SL("Save").."]"
	else
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	end
	return form
end
local function news_form(name)
	local privs = minetest.get_player_privs(name)
	local form = form_prop
	if privs["give"] then
		form = form..
			"button[0.3,0;2.5,1;btn_info;"..SL("Info").."]"..
			"button[2.75,0;2.5,1;btn_list;"..SL("List").."]"..
			"button[5.2,0;2.5,1;btn_help;"..SL("Help").."]"
	else
		form = form..
			"button[0.3,0;2.5,1;btn_info;"..SL("Info").."]"..
			"button[5.2,0;2.5,1;btn_help;"..SL("Help").."]"
	end
	form = form.."textarea[0.6,1.2;7.4,7.5;txt_news;"..SL("News:")..";"..read_news().."]"
	if privs["news"] then
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]button[4.7,7.7;3,1;btn_save;"..SL("Save").."]"
	else
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	end
	return form
end
local function help_form(name, select_id)
	local privs = minetest.get_player_privs(name)
	local form = form_prop
	if privs["give"] then
		form = form..
			"button[0.3,0;2.5,1;btn_info;"..SL("Info").."]"..
			"button[2.75,0;2.5,1;btn_list;"..SL("List").."]"..
			"button[5.2,0;2.5,1;btn_news;"..SL("News").."]"
	else
		form = form..
			"button[0.3,0;2.5,1;btn_info;"..SL("Info").."]"..
			"button[5.2,0;2.5,1;btn_news;"..SL("News").."]"
	end
	form = form.."label[0.3,1.0;"..SL("Commands:").."]"
	local list = {}
	for i, j in pairs(minetest.chatcommands) do
		local access = true
		for a, b in pairs(j.privs) do
			if privs[a] ~= b then access = false end
		end
		if access then table.insert(list, i) end
	end
	table.sort(list)
	local synopsis
	if minetest.chatcommands[list[select_id]].params then
		synopsis = list[select_id].." "..minetest.chatcommands[list[select_id]].params
	else
		synopsis = list[select_id]
	end
	synopsis = string.gsub(synopsis, "%[", "(")
	synopsis = string.gsub(synopsis, "%]", ")")
	synopsis = string.gsub(synopsis, ";", ".")
	local description
	if minetest.chatcommands[list[select_id]].description then
		description = minetest.chatcommands[list[select_id]].description
	else
		description = SL("no description")
	end
	description = string.gsub(description, "%[", "(")
	description = string.gsub(description, "%]", ")")
	description = string.gsub(description, ";", ".")
	list = table.concat(list, ",")
	form = form.."textlist[0.3,1.5;7.2,3.0;lst_comm;"..list..";"..tostring(select_id)..";]"
	form = form.."textarea[0.6,5.0;7.4,0.7;txt_synopsis;"..SL("Synopsis:")..";"..synopsis.."]"
	form = form.."textarea[0.6,6.0;7.4,1.9;txt_description;"..SL("Description:")..";"..description.."]"
	form = form.."button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	return form
end
local function list_form(name, select_id)
	local privs = minetest.get_player_privs(name)
	local form = form_prop
	form = form..
		"button[0.3,0;2.5,1;btn_info;"..SL("Info").."]"..
		"button[2.75,0;2.5,1;btn_news;"..SL("News").."]"..
		"button[5.2,0;2.5,1;btn_help;"..SL("Help").."]"
	form = form.."label[0.3,1.0;"..SL("Objects:").."]"
	local list = {}

	for i, j in pairs(minetest.registered_items) do
		if i ~= '' then table.insert(list, i) end
	end
	table.sort(list)
	local item_name = list[select_id]
	local stack_max = minetest.registered_items[list[select_id]].stack_max
	local groups = {}
	for i, j in pairs(minetest.registered_items[list[select_id]].groups) do
		table.insert(groups, i.." = "..tostring(j))
	end
	groups = table.concat(groups, ",")
	local description = minetest.registered_items[list[select_id]].description
	list = table.concat(list, ",")
	form = form.."field[0,0;0,0;txt_select;;"..item_name.."]"
	form = form.."textlist[0.3,1.5;7.2,3.0;lst_objs;"..list..";"..tostring(select_id)..";]"
	form = form.."label[0.3,4.5;"..SL("Groups:").."]"
	form = form.."textlist[0.3,5.0;7.2,1.0;lst_groups;"..groups..";;]"
	form = form.."textarea[0.6,6.5;7.4,1.5;txt_description;"..SL("Description:")..";"..description.."]"

	form = form.."button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	form = form.."label[4.0,7.9;"..SL("To invenory:").."]"
	form = form.."item_image_button[5.7,7.7;1,1;"..item_name..";btn_giveme;1]"
	form = form.."item_image_button[6.7,7.7;1,1;"..item_name..";btn_giveme_m;"..tostring(stack_max).."]"
	return form
end

-- чат-команды
minetest.register_chatcommand("info", {
	description = SL("Show information about the server"),
	func = function(name)
		minetest.show_formspec(name, "info_form", info_form(name))
	end,
})
minetest.register_chatcommand("news", {
	description = SL("Show the server's news"),
	func = function(name)
		minetest.show_formspec(name, "news_form", news_form(name))
	end,
})
minetest.register_chatcommand("new_help", {
	description = SL("Show list and description of registered chat-commands"),
	func = function(name)
		minetest.show_formspec(name, "help_form", help_form(name, 1))
	end,
})
minetest.register_chatcommand("list", {
	description = SL("Show list of registered objects"),
	privs = {give = true},
	func = function(name)
		minetest.show_formspec(name, "list_form", list_form(name, 1))
	end,
})

-- обработка событий на формах
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if (formname == "info_form")or(formname == "news_form")or(formname == "help_form")or(formname == "list_form") then
		if fields.btn_info then
			minetest.show_formspec(name, "info_form", info_form(name))
		elseif fields.btn_news then
			minetest.show_formspec(name, "news_form", news_form(name))
		elseif fields.btn_help then
			minetest.show_formspec(name, "help_form", help_form(name, 1))
		elseif fields.btn_list then
			minetest.show_formspec(name, "list_form", list_form(name, 1))
		end
	end
	if (formname == "info_form")and(fields.btn_save) then
		write_info(fields.txt_info)
		minetest.chat_send_player(player:get_player_name(), SL("Info successfully written!"))
	end
	if (formname == "news_form")and(fields.btn_save) then
		write_news(fields.txt_news)
		minetest.chat_send_player(player:get_player_name(), SL("News successfully written!"))
	end
	if (formname == "help_form")and(fields.lst_comm) then
		local chg = fields.lst_comm
		chg = string.gsub(chg, "CHG:", "")
		chg = string.gsub(chg, "DCL:", "")
		chg = tonumber(chg)
		minetest.show_formspec(name, "help_form", help_form(name, chg))
	end
	if (formname == "list_form")and(fields.lst_objs) then
		local chg = fields.lst_objs
		chg = string.gsub(chg, "CHG:", "")
		chg = string.gsub(chg, "DCL:", "")
		chg = tonumber(chg)
		minetest.show_formspec(name, "list_form", list_form(name, chg))
	end
	if (formname == "list_form")and((fields.btn_giveme)or(fields.btn_giveme_m)) then
		local count = (fields.btn_giveme)or(fields.btn_giveme_m)
		local item_name = fields.txt_select
		local item_stack = item_name.." "..count
		local inv = player:get_inventory()
		if inv:room_for_item("main", item_stack) then
			inv:add_item("main", item_stack)
			minetest.chat_send_player(player:get_player_name(), SL("Item successfully added!"))
		else
			minetest.chat_send_player(player:get_player_name(), SL("Error: Inventory is full!"))
		end
	end
end)

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end

