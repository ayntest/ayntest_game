-- 2014-08-12 GPL 3

chatnext = {}
local pfile = minetest.get_worldpath() .. '/chat_next.mt'

local function load(file)
	local file = io.open(file, 'r')
	if file then
		local table = minetest.deserialize(file:read("*all"))
		if type(table) == "table" then
			return table
		end
		file:close()
	end
	return {}
end

local function save(table, file)
	local file = io.open(file, "w")
	if file then
		file:write(minetest.serialize(table))
		file:close()
	end
	--print('file saved')
end

local function oscapture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function chatnext.whois(pname)
	local ip = minetest.get_player_ip(pname)
	if ip == nil or minetest.check_player_privs(pname, {server=true}) then
		return 'N/A'
	else
		return ip .. ', ' .. oscapture('geoiplookup '..ip..' | cut -d: -f2')
	end
end

chatnext.p_settings = load(pfile)
dofile(minetest.get_modpath('chat_next')..'/tpr.lua')
dofile(minetest.get_modpath('chat_next')..'/chatcommands.lua')

function chatnext.getopt(name, opt)
	if name == nil then return false end
	
	if chatnext.p_settings[name] == nil then
		chatnext.p_settings[name] = {}
	end
	
	local val = chatnext.p_settings[name][opt]
	if val ~= nil then
		return val
	end
	return ''
end

function chatnext.setopt(name, opt, value)
	if chatnext.p_settings[name] == nil then
		chatnext.p_settings[name] = {}
	end
	chatnext.p_settings[name][opt] = value
	--print('value: '..chatnext.p_settings[name][opt])
	return save(chatnext.p_settings, pfile)
end

function chatnext.setopt_command(name, message, setname, setvalue)
	if setvalue == 1 then
		state = 'enabled'
	else
		state = 'disabled'
	end
	--print('setvalue: '..setvalue)
	chatnext.setopt(name, setname, setvalue)
	minetest.chat_send_player(name, message .. ' ' .. state)
end

-------- join/leave --------

minetest.register_on_joinplayer(function(player)
	for _,p in ipairs(minetest.get_connected_players()) do
		local name = p:get_player_name()
		local pn = player:get_player_name()
		if ( chatnext.getopt(name, 'joins') == 1 and not pn:find( 'Guest' ) ) then
			minetest.chat_send_player(name, "*** "..pn.." joined the game")
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	for _,p in ipairs(minetest.get_connected_players()) do
		local name = p:get_player_name()
		local pn = player:get_player_name()
		if ( chatnext.getopt(name, 'joins') == 1 and not pn:find( 'Guest' ) ) then
			minetest.chat_send_player(name, '*** '..player:get_player_name().." left the game.")
		end
	end
end)
