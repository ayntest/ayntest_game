-- Minetest 0.4.10 mod: item_drop

-- make sure items are not floating in the mid-air
local function find_ground( pos )
	for i=0,15,1 do
		local n = core.get_node_or_nil( { x = pos.x, y = pos.y - i, z = pos.z } )
		if n and n.name then
			local def = core.registered_nodes[n.name]
			if def and def.walkable then
				pos.y =  math.floor( pos.y - i + 1.5 )
				return pos
			end
		end
	end
end

core.register_on_dieplayer(function(player)
	if core.setting_getbool("creative_mode") then
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

	print ( 'final pos: '..core.pos_to_string( pos ) )
	
	local player_name = player:get_player_name()
	local player_inv = player:get_inventory()

	-- drop items
	for i=1,player_inv:get_size("main") do
		core.add_item(
				pos, --{ x=pos.x + math.random( 0.1, 1.5 ), y=pos.y, z=pos.z + math.random( 0.1, 1.5 ) },
				player_inv:get_stack( 'main', i )
			)
	end
	for i=1,player_inv:get_size("craft") do
		core.add_item(pos, player_inv:get_stack("craft", i))
	end
	
	-- empty lists main and craft
	player_inv:set_list("main", {})
	player_inv:set_list("craft", {})
	
	core.chat_send_player( player_name, 'You have perished at ' .. core.pos_to_string( pos ) )
	core.chat_send_player( player_name, 'Hurry up! You have ' .. tonumber( core.setting_get( 'item_entity_ttl' ) ) .. ' seconds to pick up your stuff.' )
	return
end)

core.register_alias( 'bones:bones', 'default:gravel')
