-- 2014-08-12 GPL 3

chatnext = {}
local pfile = core.get_worldpath() .. '/chat_next.mt'

local function load(file)
	local file = io.open(file, 'r')
	if file then
		local table = core.deserialize(file:read("*all"))
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
		file:write(core.serialize(table))
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
	local ip = core.get_player_ip(pname)
	if ip == nil or core.check_player_privs(pname, {server=true}) then
		return 'N/A'
	else
		return ip .. ', ' .. oscapture('geoiplookup '..ip..' | cut -d: -f2')
	end
end

chatnext.p_settings = load(pfile)
dofile(core.get_modpath('chat_next')..'/tpr.lua')
dofile(core.get_modpath('chat_next')..'/chatcommands.lua')

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
	core.chat_send_player(name, message .. ' ' .. state)
end

-------- join/leave --------

core.register_on_joinplayer(function(player)
	for _,p in ipairs(core.get_connected_players()) do
		local name = p:get_player_name()
		local pn = player:get_player_name()
		if ( chatnext.getopt(name, 'joins') == 1 and not pn:find( 'Guest' ) ) then
			core.chat_send_player(name, "*** "..pn.." joined the game")
		end
	end
end)

core.register_on_leaveplayer(function(player)
	for _,p in ipairs(core.get_connected_players()) do
		local name = p:get_player_name()
		local pn = player:get_player_name()
		if ( chatnext.getopt(name, 'joins') == 1 and not pn:find( 'Guest' ) ) then
			core.chat_send_player(name, '*** '..player:get_player_name().." left the game.")
		end
	end
end)

-- ========= Death messages =========
local messages = {}

-- Lava death messages
messages.lava = {
	' thought lava was cool.',
	' melted into a ball of fire.',
	' couldn\'t resist that warm glow of lava.',
	' dug straight down.',
	' didn\'t know lava was hot.'
}

-- Drowning death messages
messages.water = {
	' ran out of air.',
	' failed at swimming lessons.',
	' tried to impersonate an anchor.',
	' forgot he wasn\'t a fish.',
	' blew one too many bubbles.'
}

-- Burning death messages
messages.fire = {
	' burned to a crisp.',
	' got a little too warm.',
	' got too close to the camp fire.',
	' just got roasted , hotdog style.',
	' was set aflame. More light that way.'
}

-- Other death messages
messages.other = {
	' did something fatal.',
	' died.',
	' gave up on life.',
	' is somewhat dead now.',
	' passed out -permanently.'
}

core.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	local node = core.registered_nodes[core.get_node(player:getpos()).name]
	if core.is_singleplayer() then
		player_name = 'You'
	end
	-- Death by lava
	if node.groups.lava ~= nil then
		core.chat_send_all(player_name ..  messages.lava[math.random(1,#messages.lava)] )
	-- Death by drowning
	elseif player:get_breath() == 0 then
		core.chat_send_all(player_name ..  messages.water[math.random(1,#messages.water)] )
	-- Death by fire
	elseif node.name == 'fire:basic_flame' then
		core.chat_send_all(player_name ..  messages.fire[math.random(1,#messages.fire)] )
	-- Death by something else
	else
		core.chat_send_all(player_name ..  messages.other[math.random(1,#messages.other)] )
	end
end)
