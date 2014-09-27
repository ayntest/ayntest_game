-- fameblocks mod
-- GPL v3
-- Originally by pitriss

local base_texture = 'moreblocks_iron_stone.png'

local function check_priv(pos, player)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	local pname = player:get_player_name()
	return pname == owner or pname == minetest.setting_get("name") or minetest.check_player_privs(pname, {server=true})
end

minetest.register_node('fameblocks:hexagram', {
	description = "Star of fame",
	tiles = { '[combine:16x16:0,0='..base_texture..':0,0=hexagram.png' },
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local name = placer:get_player_name() or ''
		meta:set_string("owner", name)
		meta:set_string("infotext", "Star of fame (unset)\nOwned by: "..name );
	end,
	can_dig = function(pos, player)
		return check_priv(pos, player)
	end,
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local formspec = ('size[8,5]'..
						'field[1,1;6,1;fname;Name:;]'..
						'textarea[1,2;6,2;fdeeds;Deeds:;]'..
						"button_exit[3,4;2,1;send;Save]")
		meta:set_string("formspec", formspec)
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
		if not fields.fname and not fields.fdeeds then
			return
		end
		
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local pname = sender:get_player_name() or ""
		if pname ~= owner and pname ~= minetest.setting_get("name") then
-- 			minetest.chat_send_player(sender:get_player_name(), "This can be changed only by "..owner..".")
			return
		end
		minetest.log(pname.." wrote \""..fields.fname..": "..fields.fdeeds..
		"\" on a fameblock "..minetest.pos_to_string(pos))
		meta:set_string("name", fields.fname)
		meta:set_string("deeds", fields.fdeeds)
		local finalstring = "Thanks "..fields.fname.." for his/hers support.\n"..fields.fname.." is honoured for:\n"..fields.fdeeds
		meta:set_string("infotext", finalstring)
		-- removing formspec
		meta:set_string("formspec", '')
	end,
})
