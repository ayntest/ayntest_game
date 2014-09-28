minetest.register_craftitem('farming_plus:corn_seed', {
	description = 'Corn Seeds',
	inventory_image = 'cornseed.png',
	groups = { not_in_creative_inventory=1 },
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, 'farming_plus:corn_1')
	end
})

minetest.register_node('farming_plus:corn_1', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn1.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn_2', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn2.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn_3', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn3.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn_4', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn4.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn_5', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn22.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn_6', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'corn23.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:corn', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	tiles = {'corn32.png'},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:corn_seed'} },
			{ items = {'farming_plus:corn_seed'}, rarity = 2},
			{ items = {'farming_plus:corn_seed'}, rarity = 5},
			{ items = {'farming_plus:corn_item'} },
			{ items = {'farming_plus:corn_item'}, rarity = 2 },
			{ items = {'farming_plus:corn_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem('farming_plus:corn_item', {
	description = 'Corn',
	inventory_image = 'corn.png',
})

farming.add_plant('farming_plus:corn',
{ 'farming_plus:corn_1', 'farming_plus:corn_2', 'farming_plus:corn_3', 'farming_plus:corn_4', 'farming_plus:corn_5', 'farming_plus:corn_6'},
50,
20)
