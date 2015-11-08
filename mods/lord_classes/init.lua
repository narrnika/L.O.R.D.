local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."privileges.lua")

-- Определение особенностей рас
local classes	=	{}
classes.shadow	=	{
	name	= SL("Shadow"),
	texture	= {male = "shadow_skin.png", female = "shadow_skinf.png"},
	privs	= {male = {"fly", "fast", "noclip", "GAMEshadow"}, female = {"fly", "fast", "noclip", "shout", "GAMEshadow"}},
	msg		= {male = SL("You became a shadow-male"), female = SL("You became a shadow-female")},
}
classes.orc		=	{
	name	= SL("Orc"),
	texture	= {male = "orc_skin.png", female = "orc_skin.png"},
	privs	= {male = {"interact", "shout", "home", "GAMEorc", "GAMEmale"}, female = {"interact", "shout", "home", "GAMEorc", "GAMEfemale"}},
	msg		= {male = SL("You became a orc-male"), female = SL("You became a orc-female")},
}
classes.man		=	{
	name	= SL("Man"),
	texture	= {male = "man_skin.png", female = "man_skinf.png"},
	privs	= {male = {"interact", "shout", "home", "GAMEman", "GAMEmale"}, female = {"interact", "shout", "home", "GAMEman", "GAMEfemale"}},
	msg		= {male = SL("You became a man-male"), female = SL("You became a man-female")},
}
classes.dwarf	=	{
	name	= SL("Dwarf"),
	texture	= {male = "dwarf_skin.png", female = "dwarf_skinf.png"},
	privs	= {male = {"interact", "shout", "home", "GAMEdwarf", "GAMEmale"}, female = {"interact", "shout", "home", "GAMEdwarf", "GAMEfemale"}},
	msg		= {male = SL("You became a dwarf-male"), female = SL("You became a dwarf-female")},
}
classes.hobbit	=	{
	name	= SL("Hobbit"),
	texture	= {male = "hobbit_skin.png", female = "hobbit_skinf.png"},
	privs	= {male = {"interact", "shout", "home", "GAMEhobbit", "GAMEmale"}, female = {"interact", "shout", "home", "GAMEhobbit", "GAMEfemale"}},
	msg		= {male = SL("You became a hobbit-male"), female = SL("You became a hobbit-female")},
}
classes.elf		=	{
	name	= SL("Elf"),
	texture	= {male = "elf_skin.png", female = "elf_skinf.png"},
	privs	= {male = {"interact", "shout", "home", "GAMEelf", "GAMEmale"}, female = {"interact", "shout", "home", "GAMEelf", "GAMEfemale"}},
	msg		= {male = SL("You became a elf-male"), female = SL("You became a elf-female")},
}

-- Раса и пол по умолчанию
local def_race = "shadow"
local def_gender = "female"
local def_priv = "GAMEshadow"

-- Определение расы
local function get_race(name) -- возвращает таблицу {race, gender}
	local privs = minetest.get_player_privs(name)
	local ans = {}
	if minetest.check_player_privs(name, {GAMEelf = true}) then
		ans.race = "elf"
	elseif minetest.check_player_privs(name, {GAMEdwarf = true}) then
		ans.race = "dwarf"
	elseif minetest.check_player_privs(name, {GAMEhobbit = true}) then
		ans.race = "hobbit"
	elseif minetest.check_player_privs(name, {GAMEman = true}) then
		ans.race = "man"
	elseif minetest.check_player_privs(name, {GAMEorc = true}) then
		ans.race = "orc"
	elseif minetest.check_player_privs(name, {GAMEshadow = true}) then
		ans.race = "shadow"
	end
	if minetest.check_player_privs(name, {GAMEmale = true}) then
		ans.gender = "male"
	elseif minetest.check_player_privs(name, {GAMEfemale = true}) then
		ans.gender = "female"
	end
	return ans
end

-- Присвоение расы
local function set_race(name, race, gender)
	local privs = {}
	for _, priv in pairs(classes[race].privs[gender]) do
		privs[priv] = true
	end
	minetest.set_player_privs(name, privs)
	multiskin[name].skin = classes[race].texture[gender]
	multiskin:update_player_visuals(minetest.get_player_by_name(name))
end

-- Форма выбора расы/пола
local function change_race_form()
	local form = "size[7,4]background[7,4;1,1;gui_formbg.png;true]"
	local list = {}
	for r, d in pairs(classes) do
		if r ~= def_race then table.insert(list, SL(d.name)) end
	end
	list = table.concat(list, ",")
	form = form.."label[0,0;"..minetest.formspec_escape(SL("Please select the race you wish to be:")).."]"
	form = form.."dropdown[0.0,2.3;3.0,1.0;lst_race;"..list..";1]"
	form = form.."dropdown[4.0,2.3;3.0,1.0;lst_gender;"..SL("Male")..","..SL("Female")..";1]"
	form = form.."button_exit[0.0,3.3;3.0,1.0;btn_cancel;"..SL("Cancel").."]"
	form = form.."button_exit[4.0,3.3;3.0,1.0;btn_ok;"..SL("Ok").."]"
	return form
end

-- Обработка событий формы
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if formname == "change_race" then
		if fields.btn_ok then -- кнопка Ok
			local race, gender = "", ""
			for r, d in pairs(classes) do
				if fields.lst_race == d.name then race = r end
			end
			if fields.lst_gender == SL("Male") then
				gender = "male"
			else
				gender = "female"
			end
			set_race(name, race, gender)
			minetest.chat_send_player(name, classes[race].msg[gender])
			minetest.log("action", name.." became a "..race..", "..gender)
		elseif fields.quit then -- выход с формы (cancel или esc)
			set_race(name, def_race, def_gender)
			minetest.chat_send_player(name, classes[def_race].msg[def_gender])
			minetest.log("action", name.." became a "..def_race..", "..def_gender)
		else -- переключение списков
			-- empty
		end
	end
end)

-- Вход игрока в игру
minetest.register_on_joinplayer(function(player) -- подключение игрока к игре
	local name = player:get_player_name()
	if get_race(name).race == def_race then -- раса определена - тень
		multiskin[name].skin = classes[get_race(name).race].texture[get_race(name).gender] -- ставим базовый скин
		multiskin:update_player_visuals(player) -- обновляем скин
		minetest.show_formspec(name, "change_race", change_race_form()) -- показываем форму выбора
	elseif get_race(name).race then -- раса - не тень, но определена
		multiskin[name].skin = classes[get_race(name).race].texture[get_race(name).gender] -- ставим базовый скин
		multiskin:update_player_visuals(player) -- обновляем скин
	else -- раса не определена
		set_race(name, def_race, def_gender) -- делаем тенью
		minetest.show_formspec(name, "change_race", change_race_form()) -- показываем форму выбора
	end
end)

-- Команды
minetest.register_chatcommand("race", { -- изменение расы любому игроку
	params = "<player name> <new race> <new gender>",
	privs = {race = true},
	description = SL("Change the race of any player"),
	func = function(name, params)
		if not(params and #params > 0) then -- не введено никаких параметров
			minetest.chat_send_player(name, SL("fail_message_1"))
			return
		end
		local params_list = {}
		for w in string.gmatch(params, "%S+") do
			table.insert(params_list, w)
		end
		if #params_list < 3 then -- недостаточно данных
			minetest.chat_send_player(name, SL("fail_message_2"))
		elseif not(minetest.get_player_by_name(params_list[1])) then -- неверное имя игрока
			minetest.chat_send_player(name, SL("fail_message_3"))
		elseif not(classes[params_list[2]]) then -- неверное название расы
			local list = {}
			for i in pairs(classes) do table.insert(list, i) end
			list = table.concat(list, ", ")
			minetest.chat_send_player(name, SL("fail_message_4").." "..list..")")
		elseif not(params_list[3] == 'male' or params_list[3] == 'female') then -- неверное название пола
			minetest.chat_send_player(name, SL("fail_message_5"))
		else -- всё верно
			set_race(params_list[1], params_list[2], params_list[3])
			minetest.chat_send_player(name, SL("ok_message_1").." "..params_list[1])
			minetest.chat_send_player(params_list[1], SL("ok_message_2")..classes[params_list[2]].msg[params_list[3]])
		end
	end
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
