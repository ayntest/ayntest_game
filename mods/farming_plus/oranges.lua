-- original Farming_plus oranges.lua by PilzAdam modified by MTDad.
-- converted from plant to dwarf tree, solution inspired by DocFarming Corn, new textures by MTDad.

minetest.register_craftitem("farming_plus:orange_seed", {
	description = "Orange Seeds",
	inventory_image = "farming_orange_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:orange_1")
	end
})

minetest.register_node("farming_plus:orange_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orangetrunk_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orangetrunk_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+10/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orangetrunk_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+15/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange", {
	paramtype = "light",
	walkable = true,
	drawtype = "plantlike",
	tiles = {"farming_orangetrunk_4.png"},
	drop = {
		max_items = 3,
		items = {
			{ items = {'default:stick'} },
			{ items = {'default:stick'}, rarity = 2 },
			{ items = {'default:stick'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:orange_item", {
	description = "Orange",
	inventory_image = "farming_orange.png",
	on_use = minetest.item_eat(4),
})

farming.add_plant("farming_plus:orange", {"farming_plus:orange_1", "farming_plus:orange_2", "farming_plus:orange_3"}, 250, 2)

minetest.register_node("farming_plus:orange_leaves", {
	paramtype = "light",
	walkable = true,
	drawtype = "allfaces_optional",
	drop = "",
	tiles = {"farming_fruittree_1.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_blossoms", {
	paramtype = "light",
	walkable = true,
	drawtype = "allfaces_optional",
	drop = "",
	tiles = {
			'farming_orange_blossoms.png'
		},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_fruited", {
	paramtype = "light",
	walkable = true,
	drawtype = "allfaces_optional",
	tiles = {
			'farming_orange_fruited.png'
		},
	after_dig_node = function(pos)
		core.add_node(pos, {name="farming_plus:orange_leaves"})
	end,
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming_plus:orange_item'} },
			{ items = {'farming_plus:orange_item'}, rarity = 2},
			{ items = {'farming_plus:orange_item'}, rarity = 3},
			{ items = {'farming_plus:orange_item'}, rarity = 4},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = "farming_plus:orange",
	interval = 300,
	chance = 1,
	action = function(pos, node)
		if not core.get_node_light(pos) then
			return
		end
		if core.get_node_light(pos) < 8 then
			return
		end
		pos.y=pos.y+1
		if core.get_node(pos).name ~= "air" then
			return
		end
		core.set_node(pos, {name="farming_plus:orange_leaves"})

	end
})

minetest.register_abm({
	nodenames = "farming_plus:orange_leaves",
	interval = 250,
	chance = 2,
	action = function(pos, node)
		if core.get_node( { x=pos.x, y=pos.y-2, z=pos.z } ).name ~= "farming:soil_wet" then
			return
		end
		
		if not core.get_node_light(pos) then
			return
		end
		
		if core.get_node_light(pos) < 8 then
			return
		end
		
		core.set_node(pos, {name="farming_plus:orange_blossoms"})
	end
})

minetest.register_abm({
	nodenames = "farming_plus:orange_blossoms",
	interval = 400,
	chance = 2,
	action = function(pos, node)
		if core.get_node( { x=pos.x, y=pos.y-2, z=pos.z } ).name ~= "farming:soil_wet" then
			return
		end
		
		if not core.get_node_light(pos) then
			return
		end
		
		if core.get_node_light(pos) < 8 then
			return
		end
		
		core.set_node(pos, {name="farming_plus:orange_fruited"})
	end
})

-- orange seed craft added here
minetest.register_craft({
	type = 'shapeless',
	output = 'farming_plus:orange_seed 2',
	recipe = { 'farming_plus:orange_item' }
})
