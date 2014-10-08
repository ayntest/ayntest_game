---------------------------------------------------------------------------------------
-- decoration and building material
---------------------------------------------------------------------------------------
-- * includes a wagon wheel that can be used as decoration on walls or to build (stationary) wagons
-- * dirt road - those are more natural in small old villages than cobble roads
-- * loam - no, old buildings are usually not built out of clay; loam was used
-- * straw - useful material for roofs
-- * glass pane - an improvement compared to fence posts as windows :-)
---------------------------------------------------------------------------------------

-- can be used to buid real stationary wagons or attached to walls as decoration
core.register_node("cottages:wagon_wheel", {
	description = 'Wagon wheel',
	drawtype = "signlike",
	tiles = {"cottages_wagonwheel.png"}, -- done by VanessaE!
	inventory_image = "cottages_wagonwheel.png",
	wield_image = "cottages_wagonwheel.png",
	paramtype = "light",
	paramtype2 = "wallmounted",

	sunlight_propagates = true,
	walkable = false,
	selection_box = {
			type = "wallmounted",
	},
	groups = {
		snappy=2,
		choppy=2,
		dig_immediate=2,
		attached_node=1
	},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	is_ground_content = false,
})


-- a nice dirt road for small villages or paths to fields
core.register_node("cottages:feldweg", {
	description = 'Dirt road',
	tiles = {"cottages_feldweg.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults,
	is_ground_content = false,
})


-- people didn't use clay for houses; they did build with loam
core.register_node("cottages:loam", {
	description = 'Loam',
	tiles = {"cottages_loam.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,crumbly=3},
	sounds = default.node_sound_dirt_defaults,
	is_ground_content = false,
})

-- create stairs if possible
if( stairs and stairs.register_stair_and_slab) then
	stairs.register_stair_and_slab('feldweg', 'cottages:feldweg',
		{snappy=2,choppy=2,oddly_breakable_by_hand=2},
		{'cottages_feldweg.png','default_dirt.png', 'default_grass.png','default_grass.png','cottages_feldweg.png','cottages_feldweg.png'},
		'Dirt Road Stairs',
		'Dirt Road, half height',
		default.node_sound_dirt_defaults())

	stairs.register_stair_and_slab('loam', 'cottages:loam',
		{snappy=2,choppy=2,oddly_breakable_by_hand=2},
		{'cottages_loam.png'},
		'Loam Stairs',
		'Loam Slab',
		default.node_sound_dirt_defaults())
end


-- straw is a common material for places where animals are kept indoors
-- right now, this block mostly serves as a placeholder
core.register_node("cottages:straw_ground", {
	description = 'Straw ground for animals',
	tiles = {"cottages_darkage_straw.png","cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,crumbly=3},
	sounds = default.node_sound_dirt_defaults,
	is_ground_content = false,
})


-- note: these houses look good with a single fence pile as window! the glass pane is the version for 'richer' inhabitants
core.register_node("cottages:glass_pane", {
	description = 'Simple glass pane (centered)',
	drawtype = "nodebox",
	tiles = {"cottages_glass_pane.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
		},
	},
	is_ground_content = false,
})


core.register_node("cottages:glass_pane_side", {
	description = 'Simple glass pane',
	drawtype = "nodebox",
			-- top, bottom, side1, side2, inner, outer
	tiles = {"cottages_glass_pane.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
			snappy=2,
			choppy=2,
			oddly_breakable_by_hand=2
		},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
		},
	},
	is_ground_content = false,
})

---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
core.register_craft({
	output = "cottages:wagon_wheel 3",
	recipe = {
		{"default:iron_lump", "group:stick",       "default:iron_lump" },
		{"group:stick",     "default:steel_ingot", "group:stick" },
		{"default:iron_lump", "group:stick",       "default:iron_lump" }
	}
})

-- run a wagon wheel over dirt :-)
core.register_craft({
	output = "cottages:feldweg 4",
	recipe = {
		{"",            "cottages:wagon_wheel", "" },
		{"default:dirt","default:dirt","default:dirt" }
	},
        replacements = { {'cottages:wagon_wheel', 'cottages:wagon_wheel'}, }
})

core.register_craft({
	output = "cottages:loam 4",
	recipe = {
		{"default:sand" },
		{"default:clay"}
	}
})

core.register_craft({
	output = "cottages:straw_ground 2",
	recipe = {
		{"cottages:straw_mat" },
		{"cottages:loam"}
	}
})

core.register_craft({
	output = "cottages:glass_pane 4",
	recipe = {
		{"group:stick", "group:stick", "group:stick" },
		{"group:stick", "default:glass", "group:stick" },
		{"group:stick", "group:stick", "group:stick" }
	}
})

core.register_craft({
	output = "cottages:glass_pane_side",
	recipe = {
		{"cottages:glass_pane"},
	}
})

core.register_craft({
	output = "cottages:glass_pane",
	recipe = {
		{"cottages:glass_pane_side"},
	}
})
