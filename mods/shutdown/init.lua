core.register_on_shutdown(function()
	for _, p in ipairs( core.get_connected_players() ) do
		local player_name = p:get_player_name()
		core.kick_player(player_name, 'The server is being restarted. Please, log back in again in a minute.')
	end
end)
