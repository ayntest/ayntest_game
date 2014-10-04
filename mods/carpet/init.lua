-- Carpet Mod!
-- By Jordan Snelling 2012
-- License LGPL
-- This mod adds carpets into Minetest.

minetest.register_node("carpet:red", {
	description = "Red Carpet",
	drawtype = "raillike",
	tiles = {"carpet_red_out.png", "carpet_red_cor.png", "carpet_red_one.png", "carpet_red_cen.png"},
	inventory_image = "carpet_red_out.png",
	wield_image = "carpet_red_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:orange", {
	description = "Orange Carpet",
	drawtype = "raillike",
	tiles = {"carpet_orange_out.png", "carpet_orange_cor.png", "carpet_orange_one.png", "carpet_orange_cen.png"},
	inventory_image = "carpet_orange_out.png",
	wield_image = "carpet_orange_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:yellow", {
	description = "Yellow Carpet",
	drawtype = "raillike",
	tiles = {"carpet_yellow_out.png"},
	inventory_image = "carpet_yellow_out.png",
	wield_image = "carpet_yellow_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:green", {
	description = "Green Carpet",
	drawtype = "raillike",
	tiles = {"carpet_green_out.png"},
	inventory_image = "carpet_green_out.png",
	wield_image = "carpet_green_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:cyan", {
	description = "Cyan Carpet",
	drawtype = "raillike",
	tiles = {"carpet_cyan_out.png"},
	inventory_image = "carpet_cyan_out.png",
	wield_image = "carpet_cyan_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:blue", {
	description = "Blue Carpet",
	drawtype = "raillike",
	tiles = {"carpet_blue_out.png"},
	inventory_image = "carpet_blue_out.png",
	wield_image = "carpet_blue_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:pink", {
	description = "Pink Carpet",
	drawtype = "raillike",
	tiles = {"carpet_pink_out.png"},
	inventory_image = "carpet_pink_out.png",
	wield_image = "carpet_pink_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})


minetest.register_node("carpet:black", {
	description = "Black Carpet",
	drawtype = "raillike",
	tiles = {"carpet_black_out.png"},
	inventory_image = "carpet_black_out.png",
	wield_image = "carpet_black_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:magenta", {
	description = "Magenta Carpet",
	drawtype = "raillike",
	tiles = {"carpet_magenta_out.png"},
	inventory_image = "carpet_magenta_out.png",
	wield_image = "carpet_magenta_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

minetest.register_node("carpet:white", {
	description = "White Carpet",
	drawtype = "raillike",
	tiles = {"carpet_white_out.png"},
	inventory_image = "carpet_white_out.png",
	wield_image = "carpet_white_out.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
                
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2},
})

-- Crafing

minetest.register_craft({
	output = 'carpet:red 32',
	recipe = {
		{'wool:red', 'wool:red', 'wool:red'},
		{'wool:red', 'wool:red', 'wool:red'},
	}
})

minetest.register_craft({
	output = 'carpet:orange 32',
	recipe = {
		{'wool:orange', 'wool:orange', 'wool:orange'},
		{'wool:orange', 'wool:orange', 'wool:orange'},
	}
})

minetest.register_craft({
	output = 'carpet:yellow 32',
	recipe = {
		{'wool:yellow', 'wool:yellow', 'wool:yellow'},
		{'wool:yellow', 'wool:yellow', 'wool:yellow'},
	}
})

minetest.register_craft({
	output = 'carpet:green 32',
	recipe = {
		{'wool:green', 'wool:green', 'wool:green'},
		{'wool:green', 'wool:green', 'wool:green'},
	}
})

minetest.register_craft({
	output = 'carpet:cyan 32',
	recipe = {
		{'wool:cyan', 'wool:cyan', 'wool:cyan'},
		{'wool:cyan', 'wool:cyan', 'wool:cyan'},
	}
})

minetest.register_craft({
	output = 'carpet:blue 32',
	recipe = {
		{'wool:blue', 'wool:blue', 'wool:blue'},
		{'wool:blue', 'wool:blue', 'wool:blue'},
	}
})

minetest.register_craft({
	output = 'carpet:pink 32',
	recipe = {
		{'wool:pink', 'wool:pink', 'wool:pink'},
		{'wool:pink', 'wool:pink', 'wool:pink'},
	}
})

minetest.register_craft({
	output = 'carpet:magenta 32',
	recipe = {
		{'wool:magenta', 'wool:magenta', 'wool:magenta'},
		{'wool:magenta', 'wool:magenta', 'wool:magenta'},
	}
})

minetest.register_craft({
	output = 'carpet:white 32',
	recipe = {
		{'wool:white', 'wool:white', 'wool:white'},
		{'wool:white', 'wool:white', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'carpet:black 32',
	recipe = {
		{'wool:black', 'wool:black', 'wool:black'},
		{'wool:black', 'wool:black', 'wool:black'},
	}
})
