-- Original code by Traxie21 and released with the WTFPL license
-- https://forum.minetest.net/viewtopic.php?id=4457

-- Updates by Zeno and ChaosWormz

local timeout_delay = 30

local tpr_list = {}
local tphr_list = {}

--Teleport Request System
function chatnext.tpr_send(name, param)

	local sender = name
	local receiver = param

	if receiver == "" then
		minetest.chat_send_player(sender, "Usage: /tpr <player name>")
		return
	end

	--If paremeter is valid, Send teleport message and set the table.
	if ( minetest.get_player_by_name(receiver) and chatnext.getopt( receiver, 'tpr' ) ~= 0 ) then
		minetest.chat_send_player(receiver, sender ..' is requesting to teleport to you. /tpy to accept' )
		minetest.chat_send_player(sender, 'Teleport request sent! It will time out in '.. timeout_delay ..' seconds.')

		--Write name values to list and clear old values.
		tpr_list[receiver] = sender
		--Teleport timeout delay
		minetest.after(timeout_delay, function(name)
			if tpr_list[name] ~= nil then
				tpr_list[name] = nil
			end
		end, name)
	end
end

function chatnext.tphr_send(name, param)

	local sender = name
	local receiver = param

	if receiver == "" then
		minetest.chat_send_player(sender, "Usage: /tphr <player name>")
		return
	end

	--If paremeter is valid, Send teleport message and set the table.
	if ( minetest.get_player_by_name(receiver) and chatnext.getopt( receiver, 'tpr' ) ~= 0 ) then
		minetest.chat_send_player(receiver, sender ..' is requesting that you teleport to them. /tpy to accept; /tpn to deny')
		minetest.chat_send_player(sender, 'Teleport request sent! It will time out in '.. timeout_delay ..' seconds.')

		--Write name values to list and clear old values.
		tphr_list[receiver] = sender
		--Teleport timeout delay
		minetest.after(timeout_delay, function(name)
			if tphr_list[name] ~= nil then
				tphr_list[name] = nil
			end
		end, name)
	end
end

function chatnext.tpr_deny(name, param)
	if tpr_list[name] ~= nil then
		minetest.chat_send_player(tpr_list[name], 'Teleport request denied.')
		tpr_list[name] = nil
	end
	if tphr_list[name] ~= nil then
		minetest.chat_send_player(tphr_list[name], 'Teleport request denied.')
		tphr_list[name] = nil
	end
end

-- Copied from Celeron-55's /teleport command. Thanks Celeron!
local function find_free_position_near(pos)
	local tries = {
		{x=1,y=0,z=0},
		{x=-1,y=0,z=0},
		{x=0,y=0,z=1},
		{x=0,y=0,z=-1},
	}
	for _, d in ipairs(tries) do
		local p = {x = pos.x+d.x, y = pos.y+d.y, z = pos.z+d.z}
		local n = minetest.env:get_node(p)
		if not minetest.registered_nodes[n.name].walkable then
			return p, true
		end
	end
	return pos, false
end


--Teleport Accept Systems
function chatnext.tpr_accept(name, param)

	--Check to prevent constant teleporting.
	if tpr_list[name] == nil and tphr_list[name] == nil then
		minetest.chat_send_player(name, "Usage: /tpy allows you to accept teleport requests sent to you by other players")
		return
	end

	local chatmsg
	local source = nil
	local target = nil
	local name2

	if tpr_list[name] then
		name2 = tpr_list[name]
		source = minetest.env:get_player_by_name(name)
		target = minetest.env:get_player_by_name(name2)
		chatmsg = name2 .. " is teleporting to you."
		tpr_list[name] = nil
	elseif tphr_list[name] then
		name2 = tphr_list[name]
		source = minetest.env:get_player_by_name(name2)
		target = minetest.env:get_player_by_name(name)
		chatmsg = "You are teleporting to " .. name2 .. "."
		tphr_list[name] = nil
	else
		return
	end

	-- Could happen if either player disconnects (or timeout); if so just abort
	if source == nil or target == nil then
		return
	end

	minetest.chat_send_player(name2, "Request Accepted!")
	minetest.chat_send_player(name, chatmsg)

	p = source:getpos()
	p = find_free_position_near(p)
	target:setpos(p)
end

--[[
	minetest.register_privilege("tpr_admin", {
		description chatnext.= 'Permission chatnext.to override teleport to other players. UNFINISHED',
		give_to_singleplayer = true
	})
end
]]--

print ('[Teleport Request] Loaded.')
