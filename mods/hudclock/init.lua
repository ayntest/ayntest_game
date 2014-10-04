local player_hud = { };

local timer = 0;

local mfloor = math.floor

local function floormod ( x, y )
	return mfloor(x) % y;
end

local function get_time ()
	local secs = ( 86400 * core.get_timeofday() );
	local s = floormod(secs, 60);
	local m = floormod(secs/60, 60);
	local h = floormod(secs/3600, 60);
	return ("%02d:%02d"):format(h, m);
end

core.register_globalstep(function ( dtime )
	timer = timer + dtime;
	if timer > 1 then
		for _,p in ipairs( core.get_connected_players() ) do
				local name = p:get_player_name();
				if player_hud[name] then
					if not p:hud_change( player_hud[name], 'text', get_time() ) then
						player_hud[name] = nil
					end
				else
					local h = p:hud_add({
						hud_elem_type = "text",
						position = {x=0.497, y=0.895},
						text = get_time(),
						number = 0xAAAA00,
					});
					player_hud[name] = h;
				end
		end
		timer = 0;
	end
end)

core.register_on_joinplayer(function(player)
	name = player:get_player_name()
	if player_hud[name] ~= nil then
		player:hud_remove(player_hud[name]);
		player_hud[name] = nil
	end
	return true
end)
