-- main `S` code in init.lua
local S
S = farming.S

minetest.register_craftitem("farming_plus:cucumber_seed", {
	description = S("Cucumber Seeds"),
	inventory_image = "cucumberseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming:place_seed(itemstack, placer, pointed_thing, "farming_plus:cucumber_1")
	end
})

minetest.register_node("farming_plus:cucumber_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:cucumber_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:cucumber_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:cucumber", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"cucumber4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:cucumber_seed'} },
			{ items = {'farming_plus:cucumber_seed'}, rarity = 2},
			{ items = {'farming_plus:cucumber_seed'}, rarity = 5},
			{ items = {'farming_plus:cucumber_item'} },
			{ items = {'farming_plus:cucumber_item'}, rarity = 2 },
			{ items = {'farming_plus:cucumber_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:cucumber_item", {
	description = S("Cucumber"),
	inventory_image = "cucumber.png",
})

farming:add_plant("farming_plus:cucumber", {"farming_plus:cucumber_1", "farming_plus:cucumber_2", "farming_plus:cucumber_3"}, 50, 20)
