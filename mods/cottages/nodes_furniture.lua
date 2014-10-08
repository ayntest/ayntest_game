---------------------------------------------------------------------------------------
-- furniture
---------------------------------------------------------------------------------------
-- contains:
--  * a sleeping mat - mostly for NPC that cannot afford a bed yet
--  * bench - if you don't have 3dforniture:chair, then this is the next best thing
--  * table - very simple one
--  * shelf - for stroring things; this one is 3d
--  * stovepipe - so that the smoke from the furnace can get away
--  * washing place - put it over a water source and you can 'wash' yourshelf
---------------------------------------------------------------------------------------
-- TODO: change the textures of the bed (make the clothing white, foot path not entirely covered with cloth)

-- the basic version of a bed - a sleeping mat
-- to facilitate upgrade path straw mat -> sleeping mat -> bed, this uses a nodebox

core.register_node("cottages:sleeping_mat", {
	description = 'Sleeping mat',
	drawtype = 'nodebox',
	tiles = { 'cottages_sleepingmat.png' }, -- done by VanessaE
	wield_image = 'cottages_sleepingmat.png',
	inventory_image = 'cottages_sleepingmat.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "wallmounted",
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5,-0.48,  0.5, -0.45, 0.48},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5,-0.48,  0.5, -0.25, 0.48},
		}
	},
	is_ground_content = false,
})


-- furniture; possible replacement: 3dforniture:chair
core.register_node("cottages:bench", {
	drawtype = "nodebox",
	description = 'Simple wooden bench',
	tiles = {"cottages_minimal_wood.png", "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			-- sitting area
			{-0.5, -0.15, 0.1,  0.5,  -0.05, 0.5},
			
			-- stützen
			{-0.4, -0.5,  0.2, -0.3, -0.15, 0.4},
			{ 0.3, -0.5,  0.2,  0.4, -0.15, 0.4},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0, 0.5},
		}
	},
	is_ground_content = false,
})


-- a simple table; possible replacement: 3dforniture:table
core.register_node("cottages:table", {
	description = 'Table',
	drawtype = "nodebox",
	tiles = {"cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy=2,
		choppy=2,
		oddly_breakable_by_hand=2,
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.1, -0.5, -0.1,  0.1, 0.3,  0.1},
			{ -0.5,  0.4, -0.5,  0.5, 0.5,  0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1, -0.5, -0.1,  0.1, 0.3,  0.1},
			{ -0.5, 0.4, -0.5,  0.5, 0.5,  0.5},
		},
	},
	is_ground_content = false,
})


-- looks better than two slabs impersonating a shelf; also more 3d than a bookshelf 
-- the infotext shows if it's empty or not
core.register_node("cottages:shelf", {
	description = 'Open storage shelf',
	drawtype = "nodebox",
	tiles = {"cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.3, -0.4,  0.5,  0.5},
			{  0.4, -0.5, -0.3,  0.5,  0.5,  0.5},

			{ -0.5, -0.2, -0.3,  0.5, -0.1,  0.5},
			{ -0.5,  0.3, -0.3,  0.5,  0.4,  0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
		},
	},

	on_construct = function(pos)
		local meta = core.get_meta(pos);
		meta:set_string("formspec",
					"size[8,8]"..
					"list[current_name;main;0,0;8,3;]"..
					"list[current_player;main;0,4;8,4;]")
		meta:set_string("infotext", 'Open storage shelf')
		local inv = meta:get_inventory();
		inv:set_size("main", 24);
	end,

	can_dig = function( pos,player )
			local  meta = core.get_meta( pos );
			local  inv = meta:get_inventory();
			return inv:is_empty("main");
	end,
	on_metadata_inventory_put  = function(pos, listname, index, stack, player)
		local  meta = core.get_meta( pos );
			meta:set_string('infotext', 'Open storage shelf (in use)');
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local  meta = core.get_meta( pos );
		local  inv = meta:get_inventory();
		if( inv:is_empty("main")) then
			   meta:set_string('infotext', 'Open storage shelf (empty)');
			end
	end,
	is_ground_content = false,
})

-- so that the smoke from a furnace can get out of a building
minetest.register_node("cottages:stovepipe", {
	description = 'Stovepipe',
	drawtype = "nodebox",
	tiles = {"default_steel_block.png"},
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
			{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
		},
	},
	is_ground_content = false,
})


-- this washing place can be put over a water source (it is open at the bottom)
minetest.register_node("cottages:washing", {
	description = 'Washing place',
	drawtype = "nodebox",
			-- top, bottom, side1, side2, inner, outer
	tiles = {"default_clay.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5,  0.5, -0.2, -0.2},
			{ -0.5, -0.5, -0.2, -0.4, 0.2,  0.5},
			{  0.4, -0.5, -0.2,  0.5, 0.2,  0.5},
			{ -0.4, -0.5,  0.4,  0.4, 0.2,  0.5},
			{ -0.4, -0.5, -0.2,  0.4, 0.2, -0.1},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5,  0.5, 0.2,  0.5},
		},
	},
	on_rightclick = function(pos, node, player)
		-- works only with water beneath
		local node_under = core.get_node( {x=pos.x, y=(pos.y-1), z=pos.z} );
		if( not( node_under ) or node_under.name == "ignore" or (node_under.name ~= 'default:water_source' and node_under.name ~= 'default:water_flowing')) then
			core.chat_send_player( player:get_player_name(), 'Sorry. This washing place is out of water. Please place it above water!');
		else
			core.chat_send_player( player:get_player_name(), 'You feel much cleaner after some washing.');
		end
	end,
	is_ground_content = false,

})



---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------

core.register_craft({
	output = 'cottages:table 2',
	recipe = {
		{ '', '', '' },
		{ '', 'group:wood', '', },
		{ '', 'group:stick', '' }
	}
})

core.register_craft({
	output = 'cottages:sleeping_mat',
	recipe = {
		{'cottages:straw_mat', 'cottages:straw_mat', 'cottages:straw_mat' },
	}
})

core.register_craft({
	output = 'cottages:bench',
	recipe = {
		{'', 'group:wood', '', },
		{'group:stick', '', 'group:stick', }
	}
})


core.register_craft({
	output = 'cottages:shelf',
	recipe = {
		{'group:stick', 'group:wood', 'group:stick', },
		{'group:stick', 'group:wood', 'group:stick', },
		{'group:stick', '', 'group:stick'}
	}
})

core.register_craft({
	output = 'cottages:washing 2',
	recipe = {
		{'group:stick', },
		{'default:clay',  },
	}
})

core.register_craft({
	output = 'cottages:stovepipe 2',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

