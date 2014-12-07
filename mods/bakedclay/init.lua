local clay = {}

clay.dyes = {
	{"white",      "White",      nil},
	{"grey",       "Grey",       "basecolor_grey"},
	{"black",      "Black",      "basecolor_black"},
	{"red",        "Red",        "basecolor_red"},
	{"yellow",     "Yellow",     "basecolor_yellow"},
	{"green",      "Green",      "basecolor_green"},
	{"cyan",       "Cyan",       "basecolor_cyan"},
	{"blue",       "Blue",       "basecolor_blue"},
	{"magenta",    "Magenta",    "basecolor_magenta"},
	{"orange",     "Orange",     "excolor_orange"},
	{"violet",     "Violet",     "excolor_violet"},
	{"brown",      "Brown",      "unicolor_dark_orange"},
	{"pink",       "Pink",       "unicolor_light_red"},
	{"dark_grey",  "Dark Grey",  "unicolor_darkgrey"},
	{"dark_green", "Dark Green", "unicolor_dark_green"},
}

core.register_craft({
	type = "cooking",
	output = "bakedclay:white",
	recipe = "default:clay",
})

for _, row in ipairs(clay.dyes) do
	local name = row[1]
	local desc = row[2]
	local craft_color_group = row[3]
	-- Node Definition
	core.register_node("bakedclay:"..name, {
		description = desc.." Baked Clay",
		tiles = {"baked_clay_"..name..".png"},
		groups = {cracky=3,bakedclay=1},
		sounds = default.node_sound_stone_defaults(),
	})
	if craft_color_group then
		-- Crafting from dye and white clay
		core.register_craft({
			type = "shapeless",
			output = "bakedclay:"..name,
			recipe = {"group:dye,"..craft_color_group, "group:bakedclay"},
		})
	end
end

if core.get_modpath( 'moreblocks' ) then
	local dyes = {}
	for _, row in ipairs(clay.dyes) do
		table.insert( dyes, row[1] )
	end
	stairsplus.register_nodes ( 'bakedclay', dyes )
end
