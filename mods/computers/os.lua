-- This code is distributed under GN GPL v2 license. Copyright© Jimy-Byerley

local opened_laptop = "computers:laptop_open"
local closed_laptop = "computers:laptop_close"
local connected_laptop = "computers:laptop_connect"

local welcome_message = "/* welcome to cybertronic OS v2.2 */"
local default_laptop = opened_laptop

local function floormod ( x, y )
	return (math.floor(x) % y);
end

local function get_time ()
	local secs = (60*60*24*minetest.env:get_timeofday());
	local s = floormod(secs, 60);
	local m = floormod(secs/60, 60);
	local h = floormod(secs/3600, 60);
	return ("%02d:%02d"):format(h, m);
end

computers.register_oscommand("help", "get help about a function", "help [COMMAND]", 
function(cmdline, pos, player)
	local command = string.match(cmdline, "help *(.+)")
	local message = ""
	
	if command == nil then
		for i=1,#computers.registered_command_names do
			local name = computers.registered_command_names[i]
			local short_desc = computers.registered_commands[name].short_description
			message = message..name.."     "..short_desc.."\n"
		end
		message = message.."\ntype \"help COMMAND\" to get usage"
	
	elseif command ~= nil and computers.registered_commands[command] ~= nil then
		message = command..":\t"..computers.registered_commands[command].short_description .. "\nusage:\n" .. computers.registered_commands[command].long_description
	end
	if message == "" then
		message = "help: no help for command: "..command
	end
 	
 	return message, true
end)
 
computers.register_oscommand("time", "get the time of day", "time", function(cmdline, pos, player)
	local message = "local time : "..get_time()
	return message, true
end)


computers.register_oscommand("gps", "localize a player", "gps [-l  get local coordinates] [-c PLAYER  get coordinates]\n    [-d PLAYER  get distance between computer and player]\n    [-r PLAYER   get relative coordinates]",
function(cmdline, pos, player)
	local command, opt  =string.match(cmdline, "^([^ ]+) *([^ ]+)")
	local message = ""
	
	if opt == nil then
		return "gps: usage error: see usage in help", true
	end
	
	if opt == "-l" then
		message = "* * * local coordinates * * *\nlatitude  "..pos.x.."  \nlongitude  "..pos.z.." m\naltitude  "..pos.y.." m"
	elseif opt == '-c' then
		local playername
		command, opt, playername = string.match(cmdline, "^([^ ]+) *([^ ]+) *([^ ]+)")
		local player = minetest.get_player_by_name(playername)
		-- positioning error if player not found		
		if player == nil then
			message = "gps: positioning error: unable to find player \""..playername.."\""
			return message, true
		end
		-- output message
		local p = player:getpos()
		message = "* * * local coordinates * * *\nlatitude  "..p.x.."  \nlongitude  "..p.z.." m\naltitude  "..p.y.." m"
	elseif opt == "-r" then
		local playername
		command, opt, playername = string.match(cmdline, "^([^ ]+) *([^ ]+) *([^ ]+)")
		local player = minetest.get_player_by_name(playername)
		-- positioning error if player not found		
		if player == nil then
			message = "gps: positioning error: unable to find player \""..playername.."\""
			return message, true
		end
		-- output message
		local p = player:getpos()
		message = "* * * local coordinates * * *\nlatitude  "..p.x-pos.x.."  \nlongitude  "..p.z-pos.z.." m\naltitude  "..p.y-pos.y.." m"
	elseif opt == "-d" then
		local playername
		command, opt, playername = string.match(cmdline, "^([^ ]+) *([^ ]+) *([^ ]+)")
		local player = minetest.get_player_by_name(playername)
		-- positioning error if player not found
		if player == nil then
			message = "gps: positioning error: unable to find player \""..playername.."\""
			return message, true
		end
		-- output message
		local p = player:getpos()
		message = "* * * distance to player * * *\ndistance to "..playername.." is "..math.sqrt(
			math.pow(p.x-pos.x,2) + math.pow(p.y-pos.y,2) + math.pow(p.z-pos.z,2)
		)
	end

	return message, true
end)

--[[ tempor disabled
computers.register_oscommand("mat", "get the material name of a bloc next to the computer", "mat [z+1] [z-1] [y+1] [y-1] [x+1] [x-1]", 
function(cmdline, pos, player)
	local message = "mat: error: incompatible driver (in devel program)"
	return message, false
end)
computers.register_oscommand("com", "create a connexion between two computers", "com [-c COODINATES  make a connection between this computer and an other at coordinates]\n    [-p PLAYERNAME  make a connexion between this computer and the closest computer to the player]\nWhen connected, type EOL to disconnect", 
function(cmdline, pos, player)
	local command, opt = string.match(cmdline, "^([^ ]+) *([^ ]+)")
	local node, remote_pos
	local self = minetest.get_node(pos)
	
	if opt == "-c" then
		remote_pos = {}
		command, opt, remote_pos.x, remote_pos.y, remote_pos.z = string.match(cmdline, "^([^ ]+) *([^ ]+) *(%d+)[, ] *(%d+)[, ] *(%d+)")
		
		--node = minetest.get_node(remote_pos)
	
	elseif opt == "-p" then
		local command, opt, playername = string.match(cmdline, "^([^ ]+) *([^ ]+) *([^ ]+)")
		local player = minetest.get_player_by_name(playername)
		if player == nil then
			return "com: network error: unable to find player  \""..playername.."\"", true
		end
		local p = player:getpos()
		
		local zone = 3
		
		if self.name ~= opened_laptop then
			return "com: connection error: incompatible client", true
		end
		
		for X = p.x-zone,  p.x+zone do
		for Y = p.y-zone,  p.y+zone do
		for Z = p.z-zone,  p.z+zone do
			node = minetest.get_node({x=X,y=Y,z=Z})
			if node.name == opened_laptop or node.name == closed_laptop then
				remote_pos = {x=X, y=Y, z=Z}
				break
			end
		end
		end
		end
	else
		return "com: usage error: see $ help com", false
	end
	
	node = minetest.get_node(remote_pos)
	print(remote_pos.x..","..remote_pos.y..","..remote_pos.z)
	print(node.name)
	if (node.name == opened_laptop or node.name == closed_laptop) and self.name == opened_laptop then
		-- set remote machine
		node.name = connected_laptop
		minetest.add_node(remote_pos, node)
		-- and remote meta
		local rmeta = minetest.get_meta(remote_pos)
		rmeta:set_string("destination", pos.x..", "..pos.y..", "..pos.z)
		rmeta:set_string("formspec", "field[text;;${text}]")
		rmeta:set_string("infotext", "INCOMING CONNECTION * * *")
		
		-- set local machine
		self.name = connected_laptop
		minetest.add_node(pos, self)
		-- and local meta
		local lmeta = minetest.get_meta(pos)
		lmeta:set_string("destination", remote_pos.x..", "..remote_pos.y..", "..remote_pos.z)
		lmeta:set_string("formspec", "field[text;;${text}]")
		message = "CONNECTION ETABLISHED * * *"
		
		print("[computers]: connection etablished between ("..pos.x..","..pos.y..","..pos.z..") and ("..remote_pos.x..","..remote_pos.y..","..remote_pos.z..")")
	else
		return "com: connection error: unable to create a tunnel", false
	end
	
	return message, true
end)

-- funtion called when a "computers:laptop_connect" receive a field
computers.oscommand_com_main = function(pos, formname, fields, sender)
	--get remote coordinates
	local meta = minetest.env:get_meta(pos)
	local remote_pos = {}
	remote_pos.x, remote_pos.y, remote_pos.z = string.match(meta:get_string("destination"), "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
	
	local self = minetest.env:get_node(pos)
	local node = minetest.env:get_node(remote_pos)
	
	if fields.text == nil then
		return
	elseif fields.text == "EOL" then
		print("[computers]: "..sender:get_player_name().." break connection from host at ("..pos.x..","..pos.y..","..pos.z..") with host at ("..remote_pos.x..","..remote_pos.y..","..remote_pos.z..")")
		
		
		self.name = opened_laptop
		minetest.add_node(pos, self)
		
		--set local metadata
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "END OF LINE\n* * * connection closed by local host\n\n"..welcome_message)
		
		
		node.name = opened_laptop
		minetest.add_node(remote_pos, node)
		
		--set remote metadata
		meta = minetest.env:get_meta(remote_pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "END OF LINE\n* * * connection closed by remote host\n\n"..welcome_message)
	else
		
		--verify host activity
		if node.name ~= "computers:laptop_connect" then
			minetest.chat_send_player(sender:get_player_name(), "[connection failed]")
			--set metadata
			meta:set_string("formspec", "field[text;;${text}]")
			meta:set_string("infotext", "")
		end
		
		if remote_pos.x and remote_pos.y and remote_pos.z then
			print(sender:get_player_name().." send packet to "..remote_pos.x..","..remote_pos.y..","..remote_pos.z)
			--transfer message
			local recievers = minetest.env:get_objects_inside_radius(remote_pos, 3)
			local i=1
			while recievers[i] ~= nil do
				local name = recievers[i]:get_player_name()
				minetest.chat_send_player(name, "</mechanic voice/> "..fields.text.." <//mechanic voice/>")
				i = i+1
			end
		else
			minetest.chat_send_player(sender:get_player_name(), "[bad address]")
		end
	end
end

computers.register_oscommand("restart", "reload all laptops system's", "restart",
function (cmdline, pos, player)
	print("[computers]: "..player:get_player_name().." has initialized a global computers system restarting. Minetest will redo file os.lua")
	local meta = minetest.get_meta(pos)
	meta:set_string("infotext", "** SYSTEM  : "..player:get_player_name().." has initialized a global restart")
	
	dofile(minetest.get_modpath("computers").."/os.lua")
	
	print("[computers]: all computers restarted")
	return welcome_message, true
end)
]]--
