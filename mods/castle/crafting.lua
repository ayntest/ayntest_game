minetest.register_craft({
	output = "castle:stonewall",
	recipe = {
		{"default:cobble"},
		{"default:desert_stone"},
	}
})

minetest.register_craft({
	output = "castle:rubble",
	recipe = {
		{"castle:stonewall"},
	}
})

minetest.register_craft({
	output = "castle:rubble 2",
	recipe = {
		{"default:gravel"},
		{"default:desert_stone"},
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "castle:hides 6",
	recipe = { "wool:white" , "bucket:bucket_water" },
	replacements = {
		{ 'bucket:bucket_water', 'bucket:bucket_empty' }
	}
})

minetest.register_craft({
	output = "castle:stonewall_corner",
	recipe = {
		{"", "castle:stonewall"},
		{"castle:stonewall", "default:sandstone"},
	}
})

if minetest.get_modpath("building_blocks") ~= nil then
	minetest.register_craft( {
		output = "castle:roofslate 4",
		recipe = { 
			{ "building_blocks:Tar" , "default:gravel" },
			{ "default:gravel",       "building_blocks:Tar" }
		}
	})

	minetest.register_craft( {
		output = "castle:roofslate 4",
		recipe = { 
			{ "default:gravel",       "building_blocks:Tar" },
			{ "building_blocks:Tar" , "default:gravel" }
		}
	})
end

minetest.register_craft({
	output = "castle:oak_door",
	recipe = {
		{"default:tree", "default:tree"},
		{"default:tree", "default:tree"},
		{"default:tree", "default:tree"}
	}
})

minetest.register_craft({
	output = "castle:jail_door",
	recipe = {
		{"castle:jailbars", "castle:jailbars"},
		{"castle:jailbars", "castle:jailbars"},
		{"castle:jailbars", "castle:jailbars"}
	}
})

minetest.register_craft({
	output = "castle:stairs 4",
	recipe = {
		{"castle:stonewall","",""},
		{"castle:stonewall","castle:stonewall",""},
		{"castle:stonewall","castle:stonewall","castle:stonewall"},
	}
})

minetest.register_craft({
	output = "stairs:stair_stonewall 4",
	recipe = {
		{"","","castle:stonewall"},
		{"","castle:stonewall","castle:stonewall"},
		{"castle:stonewall","castle:stonewall","castle:stonewall"},
	}
})

minetest.register_craft({
	output = "stairs:slab_stonewall 6",
	recipe = {
		{"castle:stonewall","castle:stonewall","castle:stonewall"},
	}
})

minetest.register_craft({
	output = "castle:ironbound_chest",
	recipe = {
		{"default:wood", "default:steel_ingot","default:wood"},
		{"default:wood", "default:steel_ingot","default:wood"}
	}
})

minetest.register_craft({
	output = "castle:battleaxe",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot", "default:stick","default:steel_ingot"},
		{"", "default:stick",""}
	}
})

minetest.register_craft({
	output = "castle:pavement 4",
	recipe = {
		{"default:stone", "default:cobble"},
		{"default:cobble", "default:stone"},
	}
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick"},
		{"default:obsidian"},

	}
})

core.register_craft({
	output = "castle:light",
	recipe = {
		{"default:stick", "default:glass", "default:stick"},
		{"default:glass", "default:torch", "default:glass"},
		{"default:stick", "default:glass", "default:stick"},
	}
})
