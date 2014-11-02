-- Moon Flower mod by MirceaKitsune

local OPEN_TIME_START = 0.2 -- Day time at which moon flowers open up
local OPEN_TIME_END = 0.8 -- Day time at which moon flowers close up
local OPEN_CHECK = 10 -- Interval at which to check if lighting changed

core.register_node("flowers:moonflower_closed", {
	description = "Moon flower",
	drawtype = "plantlike",
	tiles = { "moonflower_closed.png" },
	inventory_image = "moonflower_closed.png",
	wield_image = "moonflower_closed.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	groups = { snappy = 3, flammable=2, flower=1 },
	drop = 'flowers:moonflower_closed',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.1, 0.15 },
	},
	visual_scale = 0.5,
})

core.register_node("flowers:moonflower_open", {
	description = "Moon flower",
	drawtype = "plantlike",
	tiles = { "moonflower_open.png" },
	inventory_image = "moonflower_open.png",
	wield_image = "moonflower_open.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	light_source = LIGHT_MAX / 2,
	groups = { not_in_creative_inventory = 1, snappy = 3, flammable=2, flower=1 },
	drop = 'flowers:moonflower_closed',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.1, 0.15 },
	},
	visual_scale = 0.6,
})

set_moonflower = function (pos)
	-- choose the appropriate form of the moon flower
	if (core.get_node_light(pos, 0.5) == 15)
	and ((core.get_timeofday() < OPEN_TIME_START) or (core.get_timeofday() > OPEN_TIME_END)) then
		core.add_node(pos, { name = "flowers:moonflower_open" })
	else
		core.add_node(pos, { name = "flowers:moonflower_closed" })
	end
end

core.register_abm({
	nodenames = { "flowers:moonflower_closed", "flowers:moonflower_open" },
	interval = OPEN_CHECK,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		set_moonflower(pos)
	end
})
