minetest.register_craftitem('farming_plus:potato_seed', {
	description = 'Potato Seeds',
	inventory_image = 'farming_potato_seed.png',
	groups = { not_in_creative_inventory=1 },
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, 'farming_plus:potato_1')
	end
})

minetest.register_node('farming_plus:potato_1', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'farming_potato_1.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:potato_2', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	drop = '',
	tiles = {'farming_potato_2.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('farming_plus:potato', {
	paramtype = 'light',
	walkable = false,
	drawtype = 'plantlike',
	waving = 1,
	tiles = {'farming_potato_3.png'},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:potato_seed'} },
			{ items = {'farming_plus:potato_seed'}, rarity = 2},
			{ items = {'farming_plus:potato_seed'}, rarity = 5},
			{ items = {'farming_plus:potato_item'} },
			{ items = {'farming_plus:potato_item'}, rarity = 2 },
			{ items = {'farming_plus:potato_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem('farming_plus:potato_item', {
	description = 'Potato',
	inventory_image = 'potato.png',
})

farming.add_plant('farming_plus:potato', {'farming_plus:potato_1', 'farming_plus:potato_2'}, 50, 20)
