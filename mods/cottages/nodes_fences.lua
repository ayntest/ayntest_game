-- 22.01.13 Changed texture to that of the wood from the minimal development game

core.register_node("cottages:fence_small", {
	description = 'Small fence',
	drawtype = "nodebox",
	tiles = {"cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
			{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
			{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},
			{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
			{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.50, -0.50, 0.4,  0.50,  0.50,  0.5},
		},
	},
	is_ground_content = false,
})


core.register_node("cottages:fence_corner", {
	description = 'Small fence corner',
	drawtype = "nodebox",
	tiles = {"cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
			{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
			{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},
			{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
			{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},
			{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
			{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
			{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},
			{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
			{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.50, -0.50,-0.5,  0.50,  0.50,  0.5},
		},
	},
	is_ground_content = false,
})


core.register_node("cottages:fence_end", {
	description = 'Small fence end',
	drawtype = "nodebox",
	tiles = {"cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
			{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
			{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},
			{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
			{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},
			{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
			{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
			{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},
			{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
			{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},
			{ -0.50, -0.35, -0.45, -0.46, -0.20,  0.45},
			{ -0.50,  0.00, -0.45, -0.46,  0.15,  0.45},
			{ -0.50,  0.35, -0.45, -0.46,  0.50,  0.45},
			{ -0.50, -0.50, -0.50, -0.46,  0.50, -0.45},
			{ -0.50, -0.50,  0.45, -0.46,  0.50,  0.50},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.50, -0.50,-0.5,  0.50,  0.50,  0.5},
		},
	},
	is_ground_content = false,
})

core.register_craft({
	output = "cottages:fence_small 3",
	recipe = {
		{"default:fence_wood","default:fence_wood" },
	}
})

-- xfences can be configured to replace normal fences - which makes them uncraftable
if ( core.get_modpath("xfences") ~= nil ) then
	core.register_craft({
		output = "cottages:fence_small 3",
		recipe = {
			{"xfences:fence","xfences:fence" },
		}
	})
end

core.register_craft({
	output = "cottages:fence_corner",
	recipe = {
		{"cottages:fence_small","cottages:fence_small" },
	}
})

core.register_craft({
	output = "cottages:fence_small 2",
	recipe = {
		{"cottages:fence_corner" },
	}
})

core.register_craft({
	output = "cottages:fence_end",
	recipe = {
		{"cottages:fence_small","cottages:fence_small", "cottages:fence_small" },
	}
})

core.register_craft({
	output = "cottages:fence_small 3",
	recipe = {
		{"cottages:fence_end" },
	}
})




