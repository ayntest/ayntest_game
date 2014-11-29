local chunk = landrush.config:get("chunkSize")-0.5

core.register_chatcommand( 'drain', {
	params = "",
	description = 'Removes all nodes that can be built to within the current map chunk',
	privs = { server=true },
	func = function(name, param)
		local player = core.get_player_by_name(name)
		if not player then
			return
		end
		local pos = player:getpos()

		if not landrush.can_interact( pos, name ) then
			owner = landrush.get_owner( pos )
			return false, 'This area is owned by ' .. owner
		end

		local center = landrush.get_chunk_center( pos )
		center.y = pos.y
		
		for y = center.y-chunk, center.y+chunk do
			for x = center.x-chunk, center.x+chunk do
				for z = center.z-chunk, center.z+chunk do
					local node = core.get_node_or_nil( {x=x,y=y,z=z} )
					if node and core.registered_items[node.name].buildable_to then
						core.remove_node( {x=x,y=y,z=z} )
					--elseif node then
					--	print( string.format( '%s: %s', node.name, core.registered_items[node.name].buildable_to ) )
					end
				end
			end
		end
	end,
})
