-- This code is distributed under GN GPL v2 license. Copyright© Jimy-Byerley

local opened_laptop = "computers:laptop_open"
local closed_laptop = "computers:laptop_close"
local connected_laptop = "computers:laptop_connect"

local welcome_message = "/* welcome to cybertronic OS v2.2 */"
local default_laptop = opened_laptop

computers = {}

local computer_action = function(pos, formname, fields, sender)
	--use shell
	computers.execute_oscommand(fields.text, pos, sender)
end

computers.registered_command_names = {}
computers.registered_commands = {}

computers.register_oscommand = function(name, short_description, long_description, exe)
	if computers.registered_commands[name] == nil then
		computers.registered_command_names[#computers.registered_command_names+1] = name
	end
	computers.registered_commands[name] = {
		short_description=short_description, 
		long_description=long_description, 
		exe=exe
	}
end

computers.execute_oscommand = function(cmdline, pos, player)
	if cmdline == nil then return end
	local command = string.match(cmdline, "([^ ]+) *")
	if command == nil then return end
	local message = command..": command not found (try help)"
	local continue = false
	
	print(player:get_player_name().." passed command to computer : "..command)
	if computers.registered_commands[command] then
		local func = computers.registered_commands[command].exe
		if func then
			continue = true
			message, continue = func(cmdline, pos, player)
		end
	end
	
	minetest.chat_send_player(player:get_player_name(), message)
	--display message
	local meta = minetest.env:get_meta(pos)
	meta:set_string("infotext", message)
	
	return continue
end

dofile(minetest.get_modpath("computers").."/os.lua")

-- crafting


minetest.register_craft({
	output = 'computers:keyboard',
	recipe = {
		{'technology:button', 'technology:button', 'technology:button'},
		{'technology:button', 'technology:button', 'technology:button'},
		{'technology:button', 'technology:button', 'technology:button'},
	}
})
--homedecor:plastic_sheeting
minetest.register_craft({
	output = default_laptop,
	recipe = {
		{ 'technology:flat_screen_off', 'default:mese_crystal'},
		{ 'technology:electronic_card', 'default:mese_crystal'},
		{ 'computers:keyboard', '' },
	}
})

-- node defs

minetest.register_node("computers:keyboard", {
	description = "keyboard",
	stack_max = 5,
	node_placement_prediction = "",
	paramtype = "light",
	light_source = 3,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {-0.44, -0.5, -0.44,   0.44, -0.45, -0.02}},
	selection_box = {type = "fixed", fixed = {-0.44, -0.5, -0.44,   0.44, -0.45, -0.02}},
	tiles = {"keyboard_top.png", "keyboard_bottom.png", "keyboard_side.png", "keyboard_side.png", "keyboard_side.png", "keyboard_side.png"},
	walkable = true,
	groups = {choppy=2, dig_immediate=2},
})

minetest.register_node("computers:laptop_open", {
	description = 'Laptop',
	stack_max = 1,
	node_placement_prediction = "",
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {    	
		-- top part
		{-0.3, -0.45, 0.05,   0.3, 0.05, 0.1},
		-- bottom part
		{-0.3, -0.5, -0.45,     0.3, -0.45, 0.075},
	}},
	selection_box = {type = "fixed", fixed = {
		-- top part
		{-0.3, -0.45, 0.05,   0.3, 0.05, 0.1},
		-- bottom part
		{-0.3, -0.5, -0.45,     0.3, -0.45, 0.075},
	}},
	tiles = {"laptop_top.png", "laptop_bottom.png", "laptop_left.png", "laptop_right.png", "laptop_back.png", {
			image="laptop_front_general.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.5}
		}
	},
	walkable = true,
	groups = {choppy=2, dig_immediate=2},
	drop = default_laptop,
	on_punch = function(pos, node, puncher)
		node.name = "computers:laptop_close"
		minetest.env:set_node(pos, node)
	end,
	on_construct = function(pos)
		--set metadata
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", welcome_message)
	end,
	on_receive_fields = computer_action,
})

laptop_open_action = function(pos, node, puncher)
	--set opened computer
	node.name = "computers:laptop_open"
	minetest.env:set_node(pos, node)
	--set metadata
	local meta = minetest.env:get_meta(pos)
	meta:set_string("formspec", "field[text;;${text}]")
	meta:set_string("infotext", welcome_message)
end

minetest.register_node("computers:laptop_close", {
	description = 'Laptop',
	stack_max = 1,
	node_placement_prediction = "",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {
		-- bottom part
		{-0.3, -0.5, -0.45,     0.3, -0.4, 0.075},
	}},
	selection_box = {type = "fixed", fixed = {-0.3, -0.5, -0.45,     0.3, -0.4, 0.075},},
	tiles = {"laptop_cover.png", "laptop_bottom.png", "laptop_left.png", "laptop_right.png", "laptop_back.png", {
			image="laptop_front_general.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.5}
		}
	},
	walkable = true,
	groups = {choppy=2, dig_immediate=2, not_in_creative_inventory=1},
	drop = default_laptop,

	on_punch = laptop_open_action,
	on_rightclick = laptop_open_action,
})

minetest.register_node("computers:laptop_connect", {
	inventory_image = "laptop_wielded.png",
	wield_image = "laptop_wielded.png",
	stack_max = 1,
	node_placement_prediction = "",
	paramtype = "light",
	light_source = 6,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {    	
		-- top part
		{-0.3, -0.45, 0.05,   0.3, 0.05, 0.1},
		-- bottom part
		{-0.3, -0.5, -0.45,     0.3, -0.45, 0.075},
	}},
	selection_box = {type = "fixed", fixed = {
		-- top part
		{-0.3, -0.45, 0.05,   0.3, 0.05, 0.1},
		-- bottom part
		{-0.3, -0.5, -0.45,     0.3, -0.45, 0.075},
	}},
	tiles = {"laptop_top.png", "laptop_bottom.png", "laptop_left.png", "laptop_right.png", "laptop_back.png", {
			image="laptop_front_connect.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.5}
		}
	},
	walkable = true,
	groups = {choppy=2, dig_immediate=2, not_in_creative_inventory=1},
	drop = default_laptop,

	on_punch = function(pos, node, puncher)
		node.name = "computers:laptop_close"
		minetest.env:set_node(pos, node)
	end,

	on_receive_fields = computers.oscommand_com_main
})
