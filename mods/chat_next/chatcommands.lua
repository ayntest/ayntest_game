core.register_chatcommand("msg", {
	params = "<name> <message>",
	description = "Send a private message",
	privs = {shout=true},
	func = function(name, param)
		local sendto, message = param:match("^(%S+)%s(.+)$")
		if not sendto then
			return false, "Invalid usage, see /help msg."
		end
		if not core.get_player_by_name(sendto) then
			return false, "The player " .. sendto
					.. " is not online."
		end
		core.log("action", "PM from " .. name .. " to " .. sendto
				.. ": " .. message)
		core.chat_send_player(sendto, "PM from " .. name .. ": "
				.. message)
		core.sound_play( 'chat_next_pm', { to_player = sendto, gain = 0.9 } )
		return true, "Message sent."
	end,
})

-- alias for msg
core.register_chatcommand('@', minetest.chatcommands['msg'])
-- alias for teleport
core.register_chatcommand('tp', minetest.chatcommands['teleport'])

core.register_chatcommand('speed', {
	params = "<number>",
	privs = {fly=true},
	description = "Sets player speed",
	func = function(name, param)
		local player = minetest.env:get_player_by_name(name)
		player:set_physics_override( { speed = tonumber(param) } )
		--player:set_physics_override(3, 1.5, 0.5)
		minetest.chat_send_player(name, 'Speed multiplier: '..param)
	end,
})

core.register_chatcommand( 'whois', {
	params = "[name]",
	description = "Lists online players IP's",
	privs = {ban=true},
	
	func = function(name, param)
		minetest.log("action", name..' invoked /whois, param='..param)
		if param == '' then
			local players = minetest.get_connected_players()
			minetest.chat_send_player(name, '======')
			for number,data in ipairs(players) do
				local pname = data:get_player_name()
				local who = chatnext.whois(pname)
				minetest.chat_send_player( name, pname..' : ' .. chatnext.whois(pname) )
			end
			minetest.chat_send_player(name, '======')
		else
			local player = minetest.get_player_by_name(param)
			
			if ( player == nil ) then
				minetest.chat_send_player( name, param..' is not online!' )
				return false
			end
			
			local pname = player:get_player_name()
			minetest.chat_send_player(name, chatnext.whois(pname))
		end
	end,
})

-- lists online players
core.register_chatcommand( 'who', {
	params = '',
	description = "Lists online players (better run in console (press F10))",
	func = function(name, param)
			local players = minetest.get_connected_players()
			local player_count = table.getn(players)
			minetest.chat_send_player(name, 'List of players online ('..tostring(player_count)..'):')
			for number,data in ipairs(players) do
				local pname = data:get_player_name()
				if not pname:find('Guest') then
					minetest.chat_send_player(name, pname)
				end
			end
			minetest.chat_send_player(name, 'End of /who list')
	end,
})

-- from whereis mod
core.register_chatcommand( 'whereis', {
	params = "<name>",
	description = "Shows current position of player",
	privs = {ban=true},
	
	func = function (name, param)
		if param == '' then
			minetest.chat_send_player(name, '/whereis needs an argument')
			return
		elseif param == name then
			minetest.chat_send_player(name, name..' is at... Wait, you are kidding me, right?')
			return
		end

		core.log('action', name..' invoked /whereis, param='..param)
		local player = minetest.get_player_by_name(param)
		
		if ( player == nil ) then
			minetest.chat_send_player( name, param..' is not online!' )
			return false
		end
		
		local playerPos = player:getpos()
		playerPos.x = math.floor(playerPos.x)
		playerPos.y = math.floor(playerPos.y)
		playerPos.z = math.floor(playerPos.z)
		
		--distance stuff
		local me = core.get_player_by_name(name)
		local myPos = me:getpos()
		
		local distance = math.floor(math.sqrt( (myPos.x - playerPos.x)^2 + (myPos.y - playerPos.y)^2 + (myPos.z - playerPos.z)^2 ))
		minetest.chat_send_player(name, player:get_player_name()..' is at '..minetest.pos_to_string(playerPos).." about "..tostring(distance).." meters away")
		--minetest.chat_send_player(name, player:get_player_name().." is at "..minetest.pos_to_string(playerPos))
	end
})

-- toggle messages
core.register_chatcommand('setopt', {
	params = '<option> <value>',
	description = 'Set or read player settings',
	privs = { interact=true },
	
	func = function(name, param)
		minetest.log('action', name..' invoked /setopt, param='..param)
		local setname, setvalue = string.match(param, "([^ ]+) (.+)")
		if setname and setvalue then
			if setname == 'joins' then
				chatnext.setopt_command( name, 'Join/leave messages', setname, tonumber(setvalue) )
			elseif setname == 'tpr' then
				chatnext.setopt_command( name, 'Teleport requests', setname, tonumber(setvalue) )
			end
			return
		end
		local setname = string.match(param, "([^ ]+)")
		if setname then
			minetest.chat_send_player( name, 'Current value: '..chatnext.getopt( name, setname ) )
			return
		end
	end
})

-- tpr
core.register_chatcommand( 'tpr', {
	params = '<name>',
	description = 'Request teleport to another player',
	privs = {interact=true},
	func = chatnext.tpr_send

})

core.register_chatcommand( 'tphr', {
	params = '<name>',
	description = 'Request to teleport another player to you',
	privs = {interact=true},
	func = chatnext.tphr_send

})

core.register_chatcommand( 'tpy', {
	description = 'Accept teleport requests from another player',
	func = chatnext.tpr_accept
})

core.register_chatcommand("tpn", {
	description = "Deny teleport requests from another player",
	func = chatnext.tpr_deny
})

core.register_chatcommand( 'kill', {
	description = 'Kill player',
	privs = { server=true },
	func = function( name, param )
		core.log("action", name..' invoked /kill, param='..param)

		local player = core.get_player_by_name( param )
		if player ~= nil then
			player:set_hp( 0 )
		end
	end,
})

core.register_chatcommand( 'mypos', {
	description = 'Show my position',
	privs = { interact=true },
	func = function( name, param )
		local player = core.get_player_by_name( name )
		
		local pos = player:getpos()
		local mfloor = math.floor
		pos.x = mfloor( pos.x )
		pos.y = mfloor( pos.y )
		pos.z = mfloor( pos.z )
		core.chat_send_player( name, 'Your position: ' .. core.pos_to_string( pos ) )
	end
})

-- by kaeza
core.register_chatcommand( 'notice', {
	params = '<player> <text>',
	privs = { ban=true, },
	description = 'Show a notice to a player.',
	func = function(name, params)
		local target, text = params:match("(%S+)%s+(.+)")
		if not (target and text) then
			core.chat_send_player(name, "Usage: /notice <player> <text>")
			return
		end
		local player = core.get_player_by_name(target)
		if not player then
			core.chat_send_player(name, ("There's no player named '%s'."):format(target))
			return
		end
		local fs = { }
		local y = 0
		for _, line in ipairs(text:split("|")) do
			table.insert(fs, ("label[1,%f;%s]"):format(y+1, core.formspec_escape(line)))
			y = y + 0.5
		end
		table.insert(fs, 1, ("size[8,%d]"):format(y+3))
		table.insert(fs, ("button_exit[3,%f;2,0.5;ok;OK]"):format(y+2))
		fs = table.concat(fs)
		core.chat_send_player(name, "Notice sent.")
		core.after(0.3, function()
			core.show_formspec(target, "notice:notice", fs)
		end)
	end,
})

core.register_chatcommand( 'clearobj', {
	description = 'clear objects in loaded areas',
	privs = { server=true },
	func = function( name, param )
		for _, obj in pairs( core.get_objects_inside_radius({x=0,y=0,z=0}, 1000000) ) do
			if not obj:is_player() then
				obj:remove()
			end
		end
	end,
})

core.register_chatcommand( 'rsthud', {
	params = '[player]',
	description = 'Reset HUD of player',
	privs = { server=true },
	func = function( name, param )
		local player = core.get_player_by_name( name )
		for id = 0,30,1 do
			player:hud_remove( id )
		end
		
		if landrush then
			landrush.hud_destroy( player )
			landrush.hud_init( player )
		end
		if hud then
			hud.init_hud( player )
		end
		core.log("action", name .. ' invoked /rsthud')
		return true, 'HUD has been reseted!'
	end
})
