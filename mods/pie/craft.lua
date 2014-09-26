minetest.register_craft({
	type = "cooking",
	cooktime = 13.0,
	output = "pie:pie_0",
	recipe = "pie:piebatter",
})

minetest.register_craft({
        type = "cooking",
        cooktime = 13.0,
        output = "pie:apie_0",
        recipe = "pie:apiebatter",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3.0,
	output = "pie:applemuffin 4",
	recipe = "pie:amuffinbatter",
})

minetest.register_craft({
	output = "pie:piebatter 1",
	recipe = {
		{"farming_plus:sugar", "farming_plus:sugar", "farming_plus:sugar"},
		{"farming_plus:sugar", "farming_plus:dough", "farming_plus:sugar"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		},
})

minetest.register_craft({
        output = "pie:apiebatter 1",
        recipe = {
                {"farming_plus:sugar", "default:apple", "farming_plus:sugar"},
                {"farming_plus:sugar", "farming_plus:dough", "farming_plus:sugar"},
                {"farming:wheat", "farming:wheat", "farming:wheat"},
                },
})

minetest.register_craft({
	output = "pie:amuffinbatter",
	recipe = {
		{"", "farming_plus:sugar", ""},
		{"", "default:apple", ""},
		{"", "farming_plus:dough", ""},
	},
})

minetest.register_craft({
	output = "pie:knife 1",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "default:steel_ingot", ""},
		{"", "default:stick", ""},
		},
})
