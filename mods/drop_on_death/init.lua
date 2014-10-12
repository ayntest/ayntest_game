local load_time_start = os.clock()

core.register_alias( 'bones:bones', 'default:gravel')

-- make sure items are not floating in the mid-air
local function find_ground( pos )
	for i=-1,12,1 do
		local n = core.get_node_or_nil( { x = pos.x, y = pos.y - i, z = pos.z } )
		if n and n.name then
			local def = core.registered_nodes[n.name]
			if def and def.walkable then
				pos.y = pos.y - i + 1.5
				return pos
			end
		end
	end
	pos.y = pos.y + 0.5
	return pos
end

core.register_on_dieplayer( function(player)
	local player_name = player:get_player_name()
	if core.check_player_privs( player_name, { server=true } ) == true then
		return
	end

	local player_inv = player:get_inventory()
	if player_inv:is_empty("main") and
		player_inv:is_empty("craft") then
		return
	end

	local param2 = core.dir_to_facedir(player:get_look_dir())
	local pos = player:getpos()
	pos = find_ground( pos )
	pos.z = math.floor( pos.z + 0.6 )
	pos.x = math.floor( pos.x + 0.6 )

	local player_inv = player:get_inventory()

	-- drop inventory
	local size = 8 -- or maybe player_inv:get_size("main")
	for i=1, size do
		core.add_item(
				pos, --{ x=pos.x + math.random( 0.1, 1.5 ), y=pos.y, z=pos.z + math.random( 0.1, 1.5 ) },
				player_inv:get_stack( 'main', i )
			)
		player_inv:set_stack( 'main', i, nil )
	end

	-- drop crafting grid
	for i=1,player_inv:get_size( 'craft' ) do
		core.add_item(
			pos,
			player_inv:get_stack( 'craft', i )
		)
		player_inv:set_stack( 'craft', i, nil )
	end
	
	local ttl = tonumber( core.setting_get( 'item_entity_ttl' ) ) or '???'
	local pos_str = core.pos_to_string( pos ) or '???'
	core.chat_send_player( player_name, 'You have perished at ' .. pos_str )
	core.chat_send_player( player_name, 'Hurry up! You have ' .. ttl .. ' seconds to pick up your stuff.' )
	return
end)

print( string.format('[drop_on_death] loaded after ca. %.3fs', os.clock() - load_time_start) )
