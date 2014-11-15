-- Based on https://github.com/TheZenKitteh/minetest-jail

local jailpos = { x = 0, y = 0, z = 0 }
local players_in_jail = { };

minetest.register_chatcommand("jail", {
    params = "<player>",
    description = "Sends a player to Jail",
	privs = {kick=true},
    func = function ( name, param )
        local player = minetest.env:get_player_by_name(param)
        if (player) then
            players_in_jail[param] = player;
            player:setpos(jailpos)
			local privs = minetest.get_player_privs(param)
	        privs.home = nil
			privs.jailed = true
		    minetest.set_player_privs(param, privs)
			minetest.chat_send_player(param, "You have been sent to jail")
			minetest.chat_send_all(""..param.." has been sent to jail by "..name.."")
        end
    end,
})

local releasepos = { x = 0, y = 0, z = 0 }
minetest.register_chatcommand("release", {
    params = "<player>",
    description = "Releases a player from Jail",
	privs = {kick=true},
    func = function ( name, param )
        if (param == "") then return end
        local player = minetest.env:get_player_by_name(param)
        players_in_jail[param] = nil;
        if (player) then
            player:setpos(releasepos)
			local privs = minetest.get_player_privs(param)
	        privs.home = true
			privs.jailed = nil
		    minetest.set_player_privs(param, privs)
			minetest.chat_send_player(param, "You have been released from jail")
			minetest.chat_send_all(""..param.." has been released from jail by "..name.."")
        end
    end,
})

local function do_teleport ( )
    for name, player in pairs(players_in_jail) do
            player:setpos(jailpos)
    end
    minetest.after(30, do_teleport)
end
minetest.after(30, do_teleport)
