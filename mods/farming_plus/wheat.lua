-- main `S` code in init.lua
local S
S = farming.S

minetest.register_alias('farming:wheat', 'farming_plus:wheat')
minetest.register_alias('farming:seed_wheat', 'farming_plus:wheat_seed')

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
			{ items = {'farming_plus:wheat_seed'} },
			{ items = {'farming_plus:wheat_seed'}, rarity = 2},
			{ items = {'farming_plus:wheat_seed'}, rarity = 5},
			{ items = {'farming_plus:wheat'} },
			{ items = {'farming_plus:wheat'}, rarity = 2 },
			{ items = {'farming_plus:wheat'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem('farming_plus:wheat', {
	description = S('Wheat'),
	inventory_image = 'farming_wheat.png',
})

farming:add_plant('farming_plus:wheat_plant',
	{
		'farming_plus:wheat_1', 'farming_plus:wheat_2', 'farming_plus:wheat_3',
		'farming_plus:wheat_4', 'farming_plus:wheat_5', 'farming_plus:wheat_6',
		'farming_plus:wheat_7'
	},
50, 20
)
