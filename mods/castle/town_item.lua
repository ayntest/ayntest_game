minetest.register_node("castle:workbench",{
	description = "Workbench",
	tiles = {"castle_workbench_top.png", "default_wood.png", "castle_workbench_1.png", "castle_workbench_1.png", "castle_workbench_2.png", "castle_workbench_2.png"},
	paramtype2 = "facedir",
	paramtype = "light",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	drawtype = "normal",
    on_construct = function ( pos )
        local meta = minetest.get_meta( pos )
		meta:set_string( 'formspec', 'size[10,10;]' ..
			'label[1,0;Source Material]' ..
			'list[context;src;1,1;2,4;]' ..
			'label[4,0;Recipe to Use]' ..
			'list[context;rec;4,1;3,3;]' ..
			'label[7.5,0;Craft Output]' ..
			'list[context;dst;8,1;1,4;]' ..
			'list[current_player;main;1,6;8,4;]' )
        meta:set_string( 'infotext', 'Workbench' )
        local inv = meta:get_inventory()
        inv:set_size( 'src', 2 * 4 )
		inv:set_size( 'rec', 3 * 3 )
		inv:set_size( 'dst', 1 * 4 )
    end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in workbench at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to workbench at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from workbench at "..minetest.pos_to_string(pos))
	end,
})
local get_recipe = function ( inv )
	local result, needed, input
	needed = inv:get_list( 'rec' )

	result, input = minetest.get_craft_result( {
		method = 'normal',
		width = 3,
		items = needed
	} )

	local totalneed = {}

	if result.item:is_empty() then
		result = nil
	else
		result = result.item
		for _, item in ipairs( needed ) do
			if item ~= nil and not item:is_empty() and not inv:contains_item( 'src', item ) then
				result = nil
				break
			end
			if item ~= nil and not item:is_empty() then
				if totalneed[item:get_name()] == nil then
					totalneed[item:get_name()] = 1
				else
					totalneed[item:get_name()] = totalneed[item:get_name()] + 1
				end
			end
		end
		for name, number in pairs( totalneed ) do
			local totallist = inv:get_list( 'src' )
			for i, srcitem in pairs( totallist ) do
				if srcitem:get_name() == name then
					local taken = srcitem:take_item( number )
					number = number - taken:get_count()
					totallist[i] = srcitem
				end
				if number <= 0 then
					break
				end
			end
			if number > 0 then
				result = nil
				break
			end
		end
	end

	return needed, input, result
end

minetest.register_abm( {
	nodenames = { 'castle:workbench' },
	interval = 5,
	chance = 1,
	action = function ( pos, node )
		local meta = minetest.get_meta( pos )
		local inv = meta:get_inventory()
		local cresult, newinput, needed
		if not inv:is_empty( 'src' ) then
			-- Check for a valid recipe and sufficient resources to craft it
			needed, newinput, result = get_recipe( inv )
			if result ~= nil and inv:room_for_item( 'dst', result ) then
				inv:add_item( 'dst', result )
				for i, item in pairs( needed ) do
					if item ~= nil and item ~= '' then
						inv:remove_item( 'src', ItemStack( item ) )
					end
					if newinput[i] ~= nil and not newinput[i]:is_empty() then
						inv:add_item( 'src', newinput[i] )
					end
				end
			end
		end
	end
} )


local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_craft({
	output = "castle:workbench",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:wood", "default:wood","default:steel_ingot"},
		{"default:tree", "default:tree","default:steel_ingot"},
	}
})

--[[
minetest.register_node("castle:crate", {
	description = "Crate",
	drawtype = "normal",
	tiles = {"castle_crate_top.png","castle_crate_top.png","castle_crate.png","castle_crate.png","castle_crate.png","castle_crate.png"},
	groups = {choppy=3},
	paramtype = "light",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,1;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Crate")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*3)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in crate at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to crate at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from crate at "..minetest.pos_to_string(pos))
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_craft({
	output = "castle:crate",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:steel_ingot", "default:wood"},
	}
})

minetest.register_node("castle:straw", {
	description = "Straw",
	drawtype = "normal",
	tiles = {"castle_straw.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:straw",
	recipe = {
		{"default:grass_1", "default:grass_1"},
		{"default:grass_1", "default:grass_1"},
	}
})

minetest.register_node("castle:bound_straw", {
	description = "Bound Straw",
	drawtype = "normal",
	tiles = {"castle_straw_bale.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:bound_straw",
	recipe = {
		{"castle:straw", "castle:ropes"},
	}
})

stairs.register_stair_and_slab("straw", "castle:straw",
		{choppy=3, flammable=1, oddly_breakable_by_hand=3},
		{"castle_straw.png"},
		"Castle Straw Stair",
		"Castle Straw Slab",
		default.node_sound_leaves_defaults())
]]--
