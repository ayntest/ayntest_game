-- Seaweed
minetest.register_node("fishing:seaweed", {
	description = "Seaweed",
	drawtype = "plantlike",
	tiles = {"seaweed.png"},
	inventory_image = "seaweed.png",
	wield_image = "seaweed.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	selection_box = {type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_green 3",
	recipe = {"fishing:seaweed",},
})

-- Blue Coral
minetest.register_node("fishing:coral2", {
	description = "Blue Coral",
	drawtype = "plantlike",
	tiles = {"coral2.png"},
	inventory_image = "coral2.png",
	paramtype = "light",
	selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}},
	light_source = 3,
	groups = {snappy=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:cyan 3",
	recipe = {"fishing:coral2",},
})

-- Orange Coral
minetest.register_node("fishing:coral3", {
	description = "Orange Coral",
	drawtype = "plantlike",
	tiles = {"coral3.png"},
	inventory_image = "coral3.png",
	paramtype = "light",
	selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}},
	light_source = 3,
	groups = {snappy=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:orange 3",
	recipe = {"fishing:coral3",},
})

-- Pink Coral
minetest.register_node("fishing:coral4", {
	description = "Pink Coral",
	drawtype = "plantlike",
	tiles = {"coral4.png"},
	inventory_image = "coral4.png",
	paramtype = "light",
	selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}},
	light_source = 3,
	groups = {snappy=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:pink 3",
	recipe = {"fishing:coral4",},
})

-- Undersea Sand
minetest.register_node("fishing:sandy", {
	description = "Sandy",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	--drop = "default:sand",
	sounds = default.node_sound_sand_defaults(),
})

-- Register Undersea Sand
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "fishing:sandy",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -100,
})

-- Randomly generate Coral or Seaweed and have Seaweed grow up to 10 high
minetest.register_abm({
	nodenames = {"fishing:sandy"},
	neighbors = {"group:water"},
	interval = 15,
	chance = 10,

	action = function(pos, node)

		sel = math.random(1,4)
		if sel == 1 or minetest.get_node(pos).name == "fishing:seaweed" then

			local height = 0

			while minetest.get_node(pos).name == "fishing:seaweed"
			or minetest.get_node(pos).name == "fishing:sandy"
			and height < 14 do
				height = height + 1
				pos.y = pos.y + 1
			end

			if height < 14 and pos.y < 0 then
				if minetest.get_node(pos).name == "default:water_source" then
					minetest.set_node(pos, {name="fishing:seaweed"})
--					print ("GOING UP")
				end
			end

		else

			pos.y = pos.y + 1

			if minetest.get_node(pos).name == "default:water_source" then
				minetest.set_node(pos, {name="fishing:coral"..sel})
--				print ("CORAL ", sel)
			end

		end
	end,
})

-- Sashimi (Thanks to Natalia Grosner for letting me use the sashimi image)
minetest.register_craftitem("fishing:sashimi", {
	description = "Sashimi",
	inventory_image = "sashimi.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = "fishing:sashimi 2",
	recipe = {
		{'fishing:seaweed','fishing:fish_raw','fishing:seaweed'},
	}
})
