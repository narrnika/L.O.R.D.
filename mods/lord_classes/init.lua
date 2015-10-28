local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."privileges.lua")

-- Правила для имени игрока
local function check_name_player(name)
	return 
		#name > 3 and
		#name < 13
end

-- Определение особенностей рас
local class	=	{}
class.shadow=	{
	name	= SL("Shadow"),
	texture	= {male = "shadow_skin.png", female = "shadow_skinf.png"},
	privs	= {male = {"fly", "fast", "noclip", "GAMEshadow"}, female = {"fly", "fast", "noclip", "shout", "GAMEshadow"}},
	msg		= {male = SL("You became a shadow-male"), female = SL("You became a shadow-female")},
}
class.orc	=	{
	name	= SL("Orc"),
	texture	= {male = "orc_skin.png", female = "orc_skin.png"},
	privs	= {male = {"interact", "shout", "GAMEorc", "GAMEmale"}, female = {"interact", "shout", "GAMEorc", "GAMEfemale"}},
	msg		= {male = SL("You became a orc-male"), female = SL("You became a orc-female")},
}
class.man	=	{
	name	= SL("Man"),
	texture	= {male = "man_skin.png", female = "man_skinf.png"},
	privs	= {male = {"interact", "shout", "GAMEman", "GAMEmale"}, female = {"interact", "shout", "GAMEman", "GAMEfemale"}},
	msg		= {male = SL("You became a man-male"), female = SL("You became a man-female")},
}
class.dwarf	=	{
	name	= SL("Dwarf"),
	texture	= {male = "dwarf_skin.png", female = "dwarf_skinf.png"},
	privs	= {male = {"interact", "shout", "GAMEdwarf", "GAMEmale"}, female = {"interact", "shout", "GAMEdwarf", "GAMEfemale"}},
	msg		= {male = SL("You became a dwarf-male"), female = SL("You became a dwarf-female")},
}
class.hobbit=	{
	name	= SL("Hobbit"),
	texture	= {male = "hobbit_skin.png", female = "hobbit_skinf.png"},
	privs	= {male = {"interact", "shout", "GAMEhobbit", "GAMEmale"}, female = {"interact", "shout", "GAMEhobbit", "GAMEfemale"}},
	msg		= {male = SL("You became a hobbit-male"), female = SL("You became a hobbit-female")},
}
class.elf	=	{
	name	= SL("Elf"),
	texture	= {male = "elf_skin.png", female = "elf_skinf.png"},
	privs	= {male = {"interact", "shout", "GAMEelf", "GAMEmale"}, female = {"interact", "shout", "GAMEelf", "GAMEfemale"}},
	msg		= {male = SL("You became a elf-male"), female = SL("You became a elf-female")},
}

-- Раса и пол по умолчанию
local def_race = "shadow"
local def_gender = "female"
local def_priv = "GAMEshadow"

-- Присвоение расы
local function change_race(player, race, gender)
	local name = player:get_player_name()
	local privs = {}
	for _, priv in pairs(class[race].privs[gender]) do
		privs[priv] = true
	end
	print(name)
	print(race)
	minetest.set_player_privs(name, privs)
	print(gender)
	print(class[race].texture[gender])
	multiskin[name].skin = class[race].texture[gender]
	multiskin:update_player_visuals(player)
end

-- Форма-предупреждение
local function no_change_race_form()
	local form = "size[8,6]background[8,6;1,1;gui_formbg.png;true]"
	form = form.."label[0,0;"..SL("WARNING! Your name does not correspond to the rules of the server.").."]"
	form = form.."button_exit[0.0,2.0;3.0,1.0;btn_cancel;"..SL("Cancel").."]"
	return form
end

-- Форма выбора расы/пола
local function change_race_form(def)
	local form = "size[8,6]background[8,6;1,1;gui_formbg.png;true]"
	local list = {}
	for r, d in pairs(class) do
		if r ~= def_race then table.insert(list, SL(d.name)) end
	end
	list = table.concat(list, ",")
	form = form.."label[0,0;"..SL("Please select the race you wish to be:").."]"
	form = form.."dropdown[0.0,1.0;3.0,1.0;lst_race;"..list..";1]"
	form = form.."dropdown[4.0,1.0;3.0,1.0;lst_gender;"..SL("Male")..","..SL("Female")..";1]"
	form = form.."button_exit[0.0,2.0;3.0,1.0;btn_cancel;"..SL("Cancel").."]"
	form = form.."button_exit[4.0,2.0;3.0,1.0;btn_ok;"..SL("Ok").."]"
	return form
end

-- Обработка событий формы
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if formname == "change_race" then
		if fields.btn_ok then -- кнопка Ok
			local race, gender = "", ""
			for r, d in pairs(class) do
				if fields.lst_race == d.name then race = r end
			end
			if fields.lst_gender == SL("Male") then
				gender = "male"
			else
				gender = "female"
			end
			change_race(player, race, gender)
			minetest.chat_send_player(name, class[race].msg[gender])
			minetest.log("action", name.." became a "..race..", "..gender)
		elseif fields.quit then -- выход с формы (cancel или esc)
			change_race(player, def_race, def_gender)
			minetest.chat_send_player(name, class[def_race].msg[def_gender])
			minetest.log("action", name.." became a "..def_race..", "..def_gender)
		else -- переключение списков
			-- empty
		end
	end
end)

-- Вход игрока в игру
minetest.register_on_newplayer(function(player) -- регистрация нового игрока
	local name = player:get_player_name()
	if check_name_player(name) then
		minetest.show_formspec(name, "change_race", change_race_form(name))
	else
		minetest.show_formspec(name, "change_race", no_change_race_form(name))
	end
end)

--[[
minetest.register_on_joinplayer(function(player) -- вход зарегистрированного игрока
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if privs[def_priv] and check_name_player(name) then
		minetest.show_formspec(name, "change_race", change_race_form(name))
	end;
end)
]]--

-- Команды
minetest.register_chatcommand("race", { -- выбор расы, если ещё не выбрана
	privs = {[def_priv] = true},
	description = SL("Change race"),
	func = function(name)
		if check_name_player(name) then
			minetest.show_formspec(name, "change_race", change_race_form(name))
		else
			minetest.show_formspec(name, "change_race", no_change_race_form(name))
		end
	end
})

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
