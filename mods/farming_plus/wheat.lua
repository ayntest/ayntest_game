minetest.register_craftitem('farming_plus:wheat_seed', {
	description = 'Wheat Seeds',
	inventory_image = 'farming_wheat_seed.png',
	on_place = function(itemstack, placer, pointed_thing)
		return farming:place_seed(itemstack, placer, pointed_thing, 'farming_plus:wheat_1')
	end
})

minetest.register_node('farming_plus:wheat_1', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_1.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_2', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_2.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_3', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_3.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_4', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_4.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_5', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_5.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_6', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_6.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_7', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	drop = '',
	tiles = {'farming_wheat_7.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:wheat_plant', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	tiles = {'farming_wheat_8.png'},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming:seed_wheat'} },
			{ items = {'farming:seed_wheat'}, rarity = 2},
			{ items = {'farming:seed_wheat'}, rarity = 5},
			{ items = {'farming:wheat'} },
			{ items = {'farming:wheat'}, rarity = 2 },
			{ items = {'farming:wheat'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
