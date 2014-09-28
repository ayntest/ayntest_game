local homes_file = core.get_worldpath() .. "/homes"
local homepos = {}

local function loadhomes()
    local input = io.open(homes_file, "r")
    if input then
		repeat
            local x = input:read("*n")
            if x == nil then
            	break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            homepos[name:sub(2)] = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        homepos = {}
    end
end

loadhomes()

core.register_privilege("home", "Can use /sethome and /home")

local changed = false

core.register_chatcommand("home", {
	description = "Teleport you to your home point",
	privs = { home=true },
	func = function(name)
		local player = core.get_player_by_name(name)
		if player == nil then
			-- just a check to prevent the server crashing
			return false
		end
		if homepos[player:get_player_name()] then
			player:setpos(homepos[player:get_player_name()])
			core.chat_send_player(name, "Teleported to home!")
		else
			core.chat_send_player(name, "Set a home using /sethome")
		end
	end,
})

core.register_chatcommand("sethome", {
	description = "Set your home point",
	privs = { home=true },
	func = function(name)
		local player = core.get_player_by_name(name)
		local pos = player:getpos()
		homepos[player:get_player_name()] = pos
		core.chat_send_player(name, "Home set!")
		changed = true
		if changed then
			local output = io.open(homes_file, "w")
			for i, v in pairs(homepos) do
				output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
			end
			io.close(output)
			changed = false
		end
	end,
})

core.register_chatcommand( 'wayhome', {
	description = 'hud',
	privs = { home=true },
	func = function( name, param )
		local player = core.get_player_by_name( name )
		if player == nil then return end
		
		if homepos[ name ] then
			local waypoint = player:hud_add({
				hud_elem_type = 'waypoint',
				name = 'Home',
				number = 0xFFFFFF,
				position = {x=.10, y=.50},
				text = ' m',
				scale = {x=200,y=25},
				alignment = {x=0, y=0},
				world_pos = homepos[ name ]
			})
			core.chat_send_player( name, 'Waypoint set!' )
		--elseif waypoint ~= nil then
		--	player:hud_remove( waypoint )
		end
	end,
})
