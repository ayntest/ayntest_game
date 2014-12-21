-- randomize player position within the spawn plot
core.register_on_newplayer(function(player)
	local pos = core.setting_get_pos('static_spawnpoint')
	if core.setting_get('variable_spawnpoint') then
		local range = tonumber(core.setting_get('variable_spawnpoint'))
		if range > 0 then
			pos.x = pos.x + math.random(-(range), range)
			pos.z = pos.z + math.random(-(range), range)
			core.log("action", '[Spawn Plus] Moving player to pos '..pos.x..', '..pos.y)
			player:setpos( pos )
		end
	end
end)

core.register_chatcommand('spawn', {
	description = "Teleports you to spawn",
	privs = {
		shout = true
	},
	func = function(name)
		local player = core.get_player_by_name(name)
		core.sound_play("teleport",
				{to_player=player:get_player_name(), gain = 0.1})
		unified_inventory.go_spawn(player)
	end
})

core.register_chatcommand('arena', {
	description = "Teleports you to PVP arena",
	privs = {
		shout = true,
		interact = true
	},
	func = function(name)
		local player = core.get_player_by_name(name)
		core.sound_play("teleport",
				{to_player=player:get_player_name(), gain = 0.1})
		player:setpos( { x=-40, y=8, z=33 } )
	end
})

local function find_free(pos)
	for _, d in ipairs(tries) do
		local p = {x = pos.x+d.x, y = pos.y+d.y, z = pos.z+d.z}
		local n = core.get_node(p)
		if not core.registered_nodes[n.name].walkable then
			return p, true
		end
	end
end

local INTERVAL=3
local function check_pos_range()
	for _,p in ipairs(core.get_connected_players()) do
		local name = p:get_player_name()
		local pos = p:getpos()
		local spos = core.setting_get_pos('static_spawnpoint')
		local range = 10
		-- map limit
		if math.abs(pos.x) > 4500 or math.abs(pos.z) > 4500 then
			core.chat_send_player(p:get_player_name(), 'Sorry, but you should not go further than 4500 meters away.')
			--[[ teleport player back
			local back = 150
			if ( pos.x > 0 ) then pos.x = pos.x - back else pos.x = pos.x + back end
			if ( pos.z > 0 ) then pos.z = pos.z - back else pos.z = pos.z + back end
			p:setpos( { x=pos.x, y=15, z=pos.z } )
			]]--
			p:setpos( spos )
		end
	end
	core.after(INTERVAL, check_pos_range)
end

core.after(INTERVAL, check_pos_range)
