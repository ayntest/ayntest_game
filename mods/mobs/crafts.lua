minetest.register_craftitem("mobs:rat_cooked", {
	description = "Cooked Rat",
	inventory_image = "mobs_cooked_rat.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:rat_cooked",
	recipe = "mobs:rat",
	cooktime = 15,
})

minetest.register_craft({
	type = "cooking",
	recipe = "mobs:rat_cooked",
	output = "default:scorched_stuff",
	cooktime = 10,
})

minetest.register_craft({
	type = "shapeless",
	recipe = { 'default:scorched_stuff' },
	output = "dye:black",
})
