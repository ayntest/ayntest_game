-- main `S` code in init.lua
local S
S = farming.S

-- ========= CORN =========

minetest.register_craftitem('farming_plus:corn_grilled', {
	description = S('Grilled Corn'),
	inventory_image = 'corn_grilled.png',
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = 'cooking',
	output = 'farming_plus:corn_grilled',
	recipe = 'farming_plus:corn_item',
	cooktime = 15,
})

minetest.register_craftitem('farming_plus:popcorn', {
	description = S('Popcorn'),
	inventory_image = 'popcorn.png',
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = 'cooking',
	output = 'farming_plus:popcorn 3',
	recipe = 'farming_plus:corn_kernels',
	cooktime = 15,
})

minetest.register_craftitem('farming_plus:corn_kernels', {
	description = S('Corn Kernels'),
	inventory_image = 'corn_kernels.png',
})

minetest.register_craft({
	output = 'farming_plus:corn_kernels 2',
	type = 'shapeless',
	recipe = {'farming_plus:corn_item'},
})

-- ========= PUMPKIN =========
minetest.register_craftitem(":farming:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "farming_bread_pumpkin.png",
	stack_max = 1,
	on_use = minetest.item_eat(8)
})

minetest.register_craftitem(":farming:pumpkin_flour", {
	description = "Pumpkin Flour",
	inventory_image = "farming_cake_mix_pumpkin.png",
})
minetest.register_alias("farming:pumpkin_cake_mix", "farming:pumpkin_flour")

minetest.register_craft({
	output = "farming:pumpkin_flour",
	type = "shapeless",
	recipe = {"farming:flour", "farming:pumpkin"}
})

minetest.register_craft({
	type = "cooking",
	output = "farming:pumpkin_bread",
	recipe = "farming:pumpkin_flour",
	cooktime = 10
})

-- ========= TOMATO =========

minetest.register_craftitem('farming_plus:tomato_sauce', {
	description = S('Ketchup'),
	inventory_image = 'tomato_sauce.png'
})

minetest.register_craft({
	output = 'farming_plus:tomato_sauce',
	--type = 'shapeless',
	recipe = {
		{'', 'default:stick', ''},
		{'farming_plus:sugar', 'farming_plus:tomato_item 3', 'farming_plus:sugar'},
		{'', 'vessels:glass_bottle', ''}
	}
})

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_seed",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face_light",
	burntime = 7
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:big_pumpkin",
	burntime = 10
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:scarecrow",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:scarecrow_light",
	burntime = 5
})

-- DEPRECATED

core.register_craftitem('farming_plus:sugar', {
	groups = { food_sugar=1 },
	description = 'Sugar (deprecated)',
	inventory_image = 'sugar.png',
	groups = { not_in_creative_inventory=1 },
})

core.register_craftitem('farming_plus:flour', {
	description = 'Flour (deprecated)',
	inventory_image = 'farming_flour.png',
	groups = { not_in_creative_inventory=1 },
})

core.register_craftitem('farming_plus:bread', {
	description = 'Bread',
	inventory_image = 'farming_bread.png',
	on_use = minetest.item_eat(4),
	groups = { not_in_creative_inventory=1 },
})

core.register_craftitem('farming_plus:dough', {
	description = 'Dough (deprecated)',
	inventory_image = 'farming_dough.png',
	groups = { not_in_creative_inventory=1 },
})

core.register_craft({
	type = 'shapeless',
	output = 'mtfoods:sugar',
	recipe = { 'farming_plus:sugar' }
})

core.register_craft({
	type = 'shapeless',
	output = 'farming:flour',
	recipe = { 'farming_plus:flour' }
})

core.register_craft({
	type = 'shapeless',
	output = 'farming:flour',
	recipe = {'farming_plus:flour'}
})

core.register_craft({
	type = 'shapeless',
	output = 'farming:bread',
	recipe = {'farming_plus:dough'}
})
