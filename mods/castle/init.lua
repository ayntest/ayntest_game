local load_time_start = os.clock()

dofile(core.get_modpath('castle')..'/crafting.lua')
dofile(core.get_modpath('castle')..'/arrowslit.lua')
dofile(core.get_modpath('castle')..'/tapestry.lua')
dofile(core.get_modpath('castle')..'/jailbars.lua')
dofile(core.get_modpath('castle')..'/shields_decor.lua')
dofile(core.get_modpath('castle')..'/rope.lua')
--dofile(core.get_modpath('castle')..'/town_item.lua')
-- arrows are bugged atm
--dofile(core.get_modpath('castle')..'/arrow.lua')
--dofile(core.get_modpath('castle')..'/crossbow.lua')

core.register_node('castle:stonewall', {
	description = 'Castle Wall',
	drawtype = 'normal',
	tiles = {'castle_stonewall.png'},
	paramtype = light,
	drop = 'castle:stonewall',
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

core.register_node('castle:rubble', {
	description = 'Castle Rubble',
	drawtype = 'normal',
	tiles = {'castle_rubble.png'},
	paramtype = light,
	groups = {
		crumbly=3,
		falling_node=1
	},
	sounds = default.node_sound_dirt_defaults(),
})

core.register_node('castle:stonewall_corner', {
	drawtype = 'normal',
	paramtype = light,
	paramtype2 = 'facedir',
	description = 'Castle Corner',
	tiles = {
		'castle_stonewall.png', 
		'castle_stonewall.png',
		'castle_corner_stonewall1.png', 
		'castle_stonewall.png', 
		'castle_stonewall.png', 
		'castle_corner_stonewall2.png'
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

core.register_node('castle:roofslate', {
	drawtype = 'raillike',
	description = 'Roof Slates',
	inventory_image = 'castle_slate.png',
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	walkable = false,
	tiles = {'castle_slate.png'},
	groups = {cracky=3,attached_node=1},
	selection_box = {
		type = 'fixed',
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.47, 0.5},
	},
	sounds = default.node_sound_defaults(),
})

core.register_node('castle:hides', {
	drawtype = 'signlike',
	description = 'Hides',
	inventory_image = 'castle_hide.png',
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	tiles = {'castle_hide.png'},
	legacy_wallmounted = true,
	groups = {dig_immediate=2},
	walkable = false,
	selection_box = {
		type = 'fixed',
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.47, 0.5},
	},
	sounds = default.node_sound_defaults(),
})

core.register_node("castle:pavement", {
	description = "Paving Stone",
	drawtype = "normal",
	tiles = {"castle_pavement_brick.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

core.register_node("castle:dungeon_stone", {
	description = "Dungeon Stone",
	drawtype = "normal",
	tiles = {"castle_dungeon_stone.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

core.register_node("castle:light",{
	drawtype = "glasslike",
	description = "Light Block",
	sunlight_propagates = true,
	light_source = 14,
	tiles = {"castle_street_light.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
})

if core.get_modpath("moreblocks") then
	stairsplus:register_all(
		'castle', 
		'stonewall',
		'castle:stonewall',
		{
			description = "Castle Wall",
			tiles = { 'castle_stonewall.png' },
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
	stairsplus:register_all(
		'castle', 
		'pavement',
		'castle:pavement',
		{
			description = 'Paving Stone',
			tiles = { 'castle_pavement_brick.png' },
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
	stairsplus:register_all(
		'castle', 
		'dungeon_stone',
		'castle:dungeon_stone',
		{
			description = 'Dungeon Stone',
			tiles = { 'castle_dungeon_stone.png' },
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
end

doors.register_door('castle:oak_door', {
	description = 'Oak Door',
	inventory_image = 'castle_oak_door_inv.png',
	groups = {choppy=2,door=1},
	tiles_bottom = {'castle_oak_door_bottom.png', 'door_oak.png'},
	tiles_top = {'castle_oak_door_top.png', 'door_oak.png'},
	only_placer_can_open = true,
	sounds = default.node_sound_wood_defaults(),
})

doors.register_door('castle:jail_door', {
	description = 'Jail Door',
	inventory_image = 'castle_jail_door_inv.png',
	groups = {cracky=2,door=1},
	tiles_bottom = {'castle_jail_door_bottom.png', 'door_jail.png'},
	tiles_top = {'castle_jail_door_top.png', 'door_jail.png'},
	only_placer_can_open = true,
	sounds = default.node_sound_stone_defaults(),
})

core.register_node('castle:ironbound_chest',{
	drawtype = 'nodebox',
	description = 'Ironbound Chest',
	tiles = {'castle_ironbound_chest_top.png',
			'castle_ironbound_chest_top.png',
			'castle_ironbound_chest_side.png',
			'castle_ironbound_chest_side.png',
			'castle_ironbound_chest_back.png',
			'castle_ironbound_chest_front.png'},
	paramtype = 'light',
	paramtype2 = 'facedir',
	groups = {choppy=2,oddly_breakable_by_hand=2},
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.500,-0.500,-0.312,0.500,-0.062,0.312},
			{-0.500,-0.062,-0.250,0.500,0.000,0.250}, 
			{-0.500,0.000,-0.188,0.500,0.062,0.188},
			{-0.500,0.062,-0.062,0.500,0.125,0.062}, 
		},
	},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = core.get_meta(pos)
		meta:set_string('owner', placer:get_player_name() or '')
		meta:set_string('infotext', 'Ironbound Chest (owned by '..
				meta:get_string('owner')..')')
	end,
	on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string('infotext', 'Ironbound Chest')
		meta:set_string('owner', '')
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
	end,
	can_dig = function(pos,player)
		local meta = core.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('main') and default.has_locked_chest_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = core.get_meta(pos)
		if not default.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = core.get_meta(pos)
		if not default.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = core.get_meta(pos)
		if not default.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		core.log('action', player:get_player_name()..
				' moves stuff to locked chest at '..core.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		core.log('action', player:get_player_name()..
				' takes stuff from locked chest at '..core.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = core.get_meta(pos)
		local name = clicker:get_player_name()
		if default.has_locked_chest_privilege(meta, clicker) then
			core.show_formspec(
				name,
				'castle:ironbound_chest',
				default.get_locked_chest_formspec(pos)
			)
		else
			core.sound_play( 'default_chest_locked', { to_player = name, gain = 0.7 } )
		end
	end,
})

core.register_tool('castle:battleaxe', {
	description = 'Battleaxe',
	inventory_image = 'castle_battleaxe.png',
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=20, maxlevel=3},
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

print( string.format('[castle+] loaded after ca. %.2fs', os.clock() - load_time_start) )
