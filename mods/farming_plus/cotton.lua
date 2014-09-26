minetest.register_node('farming_plus:cotton_1', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_1.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_2', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_2.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_3', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_3.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_4', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_4.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_5', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_5.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_6', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_6.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton_7', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_cotton_7.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:cotton', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	tiles = {'farming_cotton_8.png'},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming:seed_cotton'} },
			{ items = {'farming:seed_cotton'}, rarity = 2},
			{ items = {'farming:seed_cotton'}, rarity = 5},
			{ items = {'farming:string'} },
			{ items = {'farming:string'}, rarity = 2 },
			{ items = {'farming:string'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
