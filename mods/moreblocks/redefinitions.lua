-- Redefinitions of some default crafting recipes:

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.15, -- Tool repair buff (15% bonus instead of 2%).
})

-- Redefinitions of some default nodes:

-- Make glass and obsidian glass framed, like the More Blocks glasses:
minetest.override_item("default:glass", {
	drawtype = "glasslike_framed",
})

minetest.override_item("default:obsidian_glass", {
	drawtype = "glasslike_framed",
})

-- Let there be light. This makes some nodes let light pass through:
minetest.override_item("default:ladder", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:sapling", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:dry_shrub", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:papyrus", {
	paramtype = "light",
	sunlight_propagates = true,
})
