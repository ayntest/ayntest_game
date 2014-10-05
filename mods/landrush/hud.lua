landrush.gstepCount = 0
landrush.playerHudItems = {}
local hud_prefix = 'Land owner: '
local shared_prefix = 'Shared: '
local owner = nil

function landrush.hud_init( player )
	local name = player:get_player_name()
	landrush.playerHudItems[name] = {
		hud_bg = player:hud_add({
			hud_elem_type = 'image',
			name = 'LRbackground',
			position = { x=0, y=0.98 },
			text = 'landrush_gui_bg.png',
			alignment = { x=1, y=0.96 },
			scale = { x = -35.6, y = -7 }
		}),
		hud_bg2 = player:hud_add({
			hud_elem_type = 'image',
			name = 'LRbackground',
			position = { x=0.64, y=0.98 },
			text = 'landrush_gui_bg.png',
			alignment = { x=1, y=0.96 },
			scale = { x = -100, y = -7 }
		}),
		hud = player:hud_add({
			hud_elem_type = 'text',
			number = 0xFFFFFF,
			name = 'LandOwner',
			position = { x=0.1, y=0.983 },
			text = hud_prefix,
			alignment = { x=1, y=1 },
			offset = { x = 0, y = -4 },
		}),
		hud_shared = player:hud_add({
			hud_elem_type = 'text',
			number = 0xFFFFFF,
			name = 'LRShared',
			position = { x=0.65, y=0.983 },
			text = shared_prefix,
			alignment = { x=1, y=1 },
			offset = { x = 0, y = -4 },
		}), lastowner=''}
end

function landrush.hud_destroy( player )
	local name = player:get_player_name()
	if landrush.playerHudItems[name] == nil then
		return false
	end
	player:hud_remove( landrush.playerHudItems[name].hud )
	player:hud_remove( landrush.playerHudItems[name].hud_shared )
	player:hud_remove( landrush.playerHudItems[name].hud_bg )
	player:hud_remove( landrush.playerHudItems[name].hud_bg2 )
	landrush.playerHudItems[name] = nil
	return true
end

function landrush.hud_redraw( player )
	local name = player:get_player_name()
	if landrush.playerHudItems[name] == nil then return false end
	
	owner = landrush.get_owner( player:getpos() )
	if owner == nil then
		--and landrush.playerHudItems[name].lastowner ~= nil then
		--print('landrush reset hud for ' .. name )
		player:hud_change(landrush.playerHudItems[name].hud,
			'text', '')
		player:hud_change(landrush.playerHudItems[name].hud_shared,
			'text', '')
		landrush.playerHudItems[name].lastowner = ''
	else
		--elseif landrush.playerHudItems[name].lastowner ~= owner then -- owner has changed
		if owner == name then
			--print('update shared list')
			local chunk = landrush.get_chunk( player:getpos() )
			local shared = ''
			for _, user in pairs(landrush.claims[chunk].shared) do
				shared = shared..' '..user
			end
			player:hud_change( landrush.playerHudItems[name].hud_shared,
				'text', 'Shared: ' .. shared )
		else
			player:hud_change( landrush.playerHudItems[name].hud_shared,
			'text', 'Shared: (?)')
		end
		
		player:hud_change( landrush.playerHudItems[name].hud,
			'text', hud_prefix .. owner )
		landrush.playerHudItems[name].lastowner = owner
	end
end

core.register_globalstep(function(dtime)
	landrush.gstepCount = landrush.gstepCount + dtime
	if landrush.gstepCount > 1 then
		local oplayers = core.get_connected_players()
		--local x = os.clock()
		for _,player in ipairs(oplayers) do
			landrush.hud_redraw( player )
		end
		--print( string.format("time in loop: %.9f", os.clock() - x ) )
		landrush.gstepCount=0
	end
end)

core.register_on_joinplayer( function(player)
	landrush.hud_init( player )
end)

core.register_on_leaveplayer( function(player)
	landrush.hud_destroy( player )
end)
