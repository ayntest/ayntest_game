core.register_node(":farming:weed", {
	description = 'Weed',
	paramtype = 'light',
	walkable = false,
	drawtype = "plantlike",
	waving = 1,
	is_ground_content = true,
	buildable_to = true,
	tiles = { 'farming_weed.png' },
	inventory_image = "farming_weed.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	groups = {
			attached_node=1,
			flammable=3,
			flora=1,
			not_in_creative_inventory=1,
			snappy=3
		},
	stack_max = 495,
	sounds = default.node_sound_leaves_defaults()
})

-- decay weed after some time
core.register_abm({
	nodenames = { 'farming:weed' },
	interval = 50,
	chance = 200,
	action = function( pos )
		core.remove_node( pos )
	end
})

core.register_abm({
	nodenames = {"farming:soil_wet", "farming:soil"},
	interval = 50,
	chance = 20,
	action = function(pos, node)
		if core.find_node_near(pos, 4, {"farming:scarecrow", "farming:scarecrow_light"}) ~= nil then
			return
		end
		pos.y = pos.y+1
		if core.get_node(pos).name == "air" then
			node.name = "farming:weed"
			core.set_node(pos, node)
		end
	end
})

-- ========= FUEL =========
core.register_craft({
	type = "fuel",
	recipe = "farming:weed",
	burntime = 1
})
