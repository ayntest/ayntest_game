core.register_node("hydro:coffeecup", {
	description = 'Coffee Cup',
	drawtype = "plantlike",
	tiles = {"hydro_coffeecup.png"},
	inventory_image = "hydro_coffeecup.png",
	wield_image = "hydro_coffeecup.png",
	use_texture_alpha = true,
	paramtype = "light",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2
	},
	sounds = default.node_sound_wood_defaults(),
	walkable = false,
	on_use = core.item_eat(2)
})

core.register_node("hydro:growlamp", {
	description = "Growlamp",
	drawtype = 'nodebox',
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16,	-7/16,	-1/16,	1/16,	8/16,	1/16},
			{-2/16,	3/16,	-2/16,	2/16,	6/16,	2/16},
			{-3/16,	-6/16,	-2/16,	3/16,	3/16,	2/16},
			{-2/16,	-6/16,	-3/16,	2/16,	3/16,	3/16},
		}
	},
	tiles = {"hydro_growlamp_top.png", "hydro_growlamp_bottom.png", "hydro_growlamp_side.png"},
	--inventory_image = "hydro_growlamp_side.png",
	paramtype = "light",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15,
	groups = {
		snappy=2,
		cracky=3,
		oddly_breakable_by_hand=3,
		flammable=3
	},
	sounds = default.node_sound_glass_defaults(),
	node_placement_prediction = "hydro:coffeecup",
})

core.register_node("hydro:wine", {
	description = 'Wine Bottle',
	drawtype = 'nodebox',
	tiles = {
		'hydro_bottle_wine_top.png',
		'hydro_bottle_wine_sides.png'
	},
	inventory_image = 'hydro_bottle_wine_inv.png',
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2,
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-.022, -.12, -.022, .022, -0.1, .022}, -- wider upper
			{-.02, -.25, -.02, .02, -0.1, .02}, -- upper
			{-.045, -.5, -.045, .045, -.22, .045}, -- base
		}
	},
	sounds = default.node_sound_glass_defaults(),
	on_use = core.item_eat(1)
})

core.register_node("hydro:promix", {
	description = "Promix",
	tiles = {"hydro_promix.png"},
	groups = {
		crumbly = 3,
		soil = 2
	},
	sounds = default.node_sound_dirt_defaults(),
})

core.register_node("hydro:roastedcoffee", {
	description = "Roasted Coffee",
	tiles = {"hydro_roastedcoffee.png"},
	inventory_image = core.inventorycube("hydro_roastedcoffee.png"),
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})

--
-- Rose bushes
--
core.register_node("hydro:rosebush", {
	description = "Rose Bush",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_white", {
	description = "Rose Bush (White)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_white.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_yellow", {
	description = "Rose Bush (Yellow)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_yellow.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_violet", {
	description = "Rose Bush (Violet)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_violet.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_blue", {
	description = "Rose Bush (Blue)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_blue.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_pink", {
	description = "Rose Bush (Pink)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_pink.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})
