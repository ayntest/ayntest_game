-- main `S` code in init.lua
local S
S = farming.S

minetest.register_craftitem('farming_plus:cotton_seed', {
	description = 'Cotton Seeds',
	inventory_image = 'farming_cotton_seed.png',
	on_place = function(itemstack, placer, pointed_thing)
		return farming:place_seed(itemstack, placer, pointed_thing, 'farming_plus:cotton_1')
	end
})

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
			{ items = {'farming_plus:cotton_seed'} },
			{ items = {'farming_plus:cotton_seed'}, rarity = 2},
			{ items = {'farming_plus:cotton_seed'}, rarity = 5},
			{ items = {'farming_plus:string'} },
			{ items = {'farming_plus:string'}, rarity = 2 },
			{ items = {'farming_plus:string'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem('farming_plus:string', {
	description = S('Cotton'),
	inventory_image = 'farming_cotton.png',
})
minetest.register_alias("farming:cotton", "farming_plus:string")
minetest.register_alias("farming:string", "farming_plus:string")
minetest.register_alias('farming:seed_cotton', 'farming_plus:cotton_seed')

farming:add_plant('farming_plus:cotton',
	{
		'farming_plus:cotton_1', 'farming_plus:cotton_2', 'farming_plus:cotton_3',
		'farming_plus:cotton_4', 'farming_plus:cotton_5', 'farming_plus:cotton_6',
		'farming_plus:cotton_7'
	},
	50,	20
)
