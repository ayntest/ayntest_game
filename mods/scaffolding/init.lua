
minetest.register_craft({
	output = 'scaffolding:scaffolding',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'', 'group:stick', ''},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_node("scaffolding:scaffolding", {
	description = "scaffolding",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
    	paramtype = "light",
    	paramtype2 = "facedir",
	node_box = {
        	type = "fixed",
        	fixed = {
            	{ -0.5, -0.5, -0.5, -0.4,  -0.4, 0.5 },
            	{  -0.5, 0.5, -0.5,  -0.4,  0.4, 0.5 },
            	{  0.5,  0.5, -0.5,  0.4,  0.4,  0.5 },
            	{  0.5, -0.5, -0.5,  0.4, -0.4,  0.5 },
		{ -0.5, -0.5, -0.5,  0.5, -0.4, -0.4 },
		{ -0.5,  0.4, -0.5,  0.5,  0.5, -0.4 },
		{ -0.5, -0.5, -0.5, -0.4,  0.5, -0.4 },
		{  0.4, -0.5, -0.5,  0.5,  0.5, -0.4 },
		{ -0.5, -0.5,  0.4,  0.5, -0.4,  0.5 },
		{ -0.5,  0.4,  0.4,  0.5,  0.5,  0.5 },
		{ -0.5, -0.5,  0.4, -0.4,  0.5,  0.5 },
		{  0.4, -0.5,  0.4,  0.5,  0.5,  0.5 },      	
            },
	},
	climbable = true,
	walkable = false,
	is_ground_content = true,
	groups = {scaffolding=1,dig_immediate=3,flammable=3},
	--sounds = default.node_sound_wood_defaults()
})

local scaffolding = {}
-- This uses a trick: you can first define the recipes using all of the base
-- colors, and then some recipes using more specific colors for a few non-base
-- colors available. When crafting, the last recipes will be checked first.
scaffolding.dyes = {
	{"white",      "White",      "basecolor_white"},	
	{"red",        "Red",        "basecolor_red"},
	{"yellow",     "Yellow",     "basecolor_yellow"},
	{"blue",       "Blue",       "basecolor_blue"},
	{"orange",     "Orange",     "excolor_orange"},
	{"violet",     "Violet",     "excolor_violet"},	
	{"grey",       "Grey",       "basecolor_grey"},
	{"darkgrey",  "Dark grey",  "excolor_darkgrey"},
	{"black",      "Black",      "basecolor_black"},
	{"cyan",       "Cyan",       "basecolor_cyan"},
	{"green",      "Green",   "basecolor_green"},
	{"magenta",    "Magenta dye",   "basecolor_magenta"},
}

for _, row in ipairs(scaffolding.dyes) do
	local name = row[1]
	local desc = row[2]
	local craft_color_group = row[3]
	-- Node Definition
	minetest.register_node("scaffolding:scaffolding_"..name, {
		description = desc.." scaffolding",
		tiles = {"coloredwood_wood_"..name..".png"},
		drawtype = "nodebox",
    	paramtype = "light",
    	paramtype2 = "facedir",
	node_box = {
        	type = "fixed",
        	fixed = {
            	{ -0.5, -0.5, -0.5, -0.4,  -0.4, 0.5 },
            	{  -0.5, 0.5, -0.5,  -0.4,  0.4, 0.5 },
            	{  0.5,  0.5, -0.5,  0.4,  0.4,  0.5 },
            	{  0.5, -0.5, -0.5,  0.4, -0.4,  0.5 },
		{ -0.5, -0.5, -0.5,  0.5, -0.4, -0.4 },
		{ -0.5,  0.4, -0.5,  0.5,  0.5, -0.4 },
		{ -0.5, -0.5, -0.5, -0.4,  0.5, -0.4 },
		{  0.4, -0.5, -0.5,  0.5,  0.5, -0.4 },
		{ -0.5, -0.5,  0.4,  0.5, -0.4,  0.5 },
		{ -0.5,  0.4,  0.4,  0.5,  0.5,  0.5 },
		{ -0.5, -0.5,  0.4, -0.4,  0.5,  0.5 },
		{  0.4, -0.5,  0.4,  0.5,  0.5,  0.5 },      	
            },
	},
	climbable = true,
	walkable = false,
	is_ground_content = true,
	groups = {scaffolding=1,dig_immediate=3,flammable=3},
--	sounds = default.node_sound_wood_defaults()
	})
	if craft_color_group then
		minetest.register_craft({
			type = "shapeless",
			output = 'scaffolding:scaffolding_'..name,
			recipe = {'group:'..craft_color_group, 'group:scaffolding'},
		
		})
	
	end
	--[[
	minetest.register_craft({
		output = 'scaffolding:scaffolding_'..name,
		recipe = {
			{'coloredwood:stick_'..name, '', 'coloredwood:stick_'..name},
			{'', 'coloredwood:stick_'..name, ''},
			{'coloredwood:stick_'..name, '', 'coloredwood:stick_'..name},
			}
	})
	]]--
end

minetest.register_craft({
	type = "fuel",
	recipe = "group:scaffolding",
	burntime = 15,
})
