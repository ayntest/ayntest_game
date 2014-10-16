---------------------------------------------------------------------------------------
-- simple anvil that can be used to repair tools
---------------------------------------------------------------------------------------
-- * can be used to repair tools
-- * the hammer gets dammaged a bit at each repair step
---------------------------------------------------------------------------------------
-- spawn particles was taken from the shooter mod
-- Boilerplate to support localized strings if intllib mod is installed.

HAMMERS = {
	hammersteel = {
		desc = 'Steel', recipe = 'default:steel_ingot',
		image = 'cottages_tool_steelhammer.png',
		repair = -1800,
		damage = 2600
		},
	hammerbronze = {
		desc = 'Bronze', recipe = 'default:bronze_ingot',
		image = 'cottages_tool_bronzehammer.png',
		repair = -1900,
		damage = 2300
		},
	hammermese = {
		desc = 'Mese', recipe = 'default:mese_crystal',
		image = 'cottages_tool_mesehammer.png',
		repair = -2500,
		damage = 1900
		},
	hammerdiamond = {
		desc = 'Diamond', recipe = 'default:diamond',
		image = 'cottages_tool_diamondhammer.png',
		repair = -3050,
		damage = 1700
		},
	hammerobsidian = {
		desc = 'Obsidian', recipe = 'default:obsidian',
		image = 'cottages_tool_obsidianhammer.png',
		repair = -2050,
		damage = 1200
		}
	}

local function get_particle_pos(p, v, d)
	return vector.add(p, vector.multiply(v, {x=d, y=d, z=d}))
end

local function spawn_particles(pos, texture)
	texture = 'cottages_anvil_hit.png'
	local spread = {x=0.1, y=0.1, z=0.1}
	minetest.add_particlespawner(
		8,
		0.02,
		vector.subtract(pos, spread),
		vector.add(pos, spread),
		{x=-1, y=1, z=-1},
		{x=1, y=2, z=1},
		{x=-2, y=-2, z=-2},
		{x=2, y=-2, z=2},
		0.1, 0.75,
		0.5,
		1,
		false,
		texture
	)
end

for _,tool in pairs(HAMMERS) do
	minetest.register_craft({
		output = 'cottages:' .. _,
		recipe = {
			{ tool.recipe,	tool.recipe,	tool.recipe },
			{ tool.recipe,	'group:stick',	'' },
			{ '',			'group:stick',	'' }
			}
	})

	minetest.register_tool('cottages:' .. _, {
		description			= tool.desc..' hammer',
		inventory_image		= tool.image,
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level=1,
			groupcaps={
				-- about equal to a stone pick (it's not intended as a tool)
				cracky={times={[2]=2.00, [3]=1.20}, uses=30, maxlevel=1},
			},
			damage_groups = {fleshy=6},
		},
	})
end
minetest.register_alias('cottages:hammer', 'cottages:hammersteel')

minetest.register_node("cottages:anvil", {
	drawtype = "nodebox",
	description = 'Anvil',
	tiles = {"moreblocks_coal_stone.png"},
	paramtype  = "light",
        paramtype2 = "facedir",
	groups = {cracky=2},
	-- the nodebox model comes from realtest
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.3,0.5,-0.4,0.3},
				{-0.35,-0.4,-0.25,0.35,-0.3,0.25},
				{-0.3,-0.3,-0.15,0.3,-0.1,0.15},
				{-0.35,-0.1,-0.2,0.35,0.1,0.2},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.3,0.5,-0.4,0.3},
				{-0.35,-0.4,-0.25,0.35,-0.3,0.25},
				{-0.3,-0.3,-0.15,0.3,-0.1,0.15},
				{-0.35,-0.1,-0.2,0.35,0.1,0.2},
			}
	},
	
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos);
		meta:set_string("infotext", 'Anvil');
		local inv = meta:get_inventory();
		inv:set_size("input",    1);
		-- inv:set_size("material", 9);
		-- inv:set_size("sample",   1);
		inv:set_size("hammer",   1);
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", ('Anvil (owned by %s)'):format((meta:get_string("owner") or "")) )
		meta:set_string("formspec",
			"size[8,8]"..
			--"image[7,3;1,1;cottages_tool_steelhammer.png]"..
			--"list[current_name;sample;0,0.5;1,1;]"..
			"list[current_name;input;2.5,1.5;1,1;]"..
			--"list[current_name;material;5,0;3,3;]"..
			"list[current_name;hammer;5,3;1,1;]"..
			--"label[0.0,0.0;Sample:]"..
			"label[2.5,1.0;Workpiece:]"..
			"label[6.0,2.7;Optional storage]"..
			"label[6.0,3.0;for your hammer]"..
			"label[0,-0.5;Anvil]"..
			"label[2.5,-0.5;"..("Owner: %s"):format(meta:get_string('owner') or "").."]"..
			"label[0,3.0;Punch anvil with hammer to]"..
			"label[0,3.3;repair tool in workpiece-slot.]"..
			"list[current_player;main;0,4;8,4;]");
	end,

	can_dig = function(pos,player)

		local meta  = minetest.get_meta(pos);
		local inv   = meta:get_inventory();
		local owner = meta:get_string('owner');

		if(  not( inv:is_empty("input"))
			-- or not( inv:is_empty("material"))
			-- or not( inv:is_empty("sample"))
			or not( inv:is_empty("hammer"))
			or not( player )
			or ( owner and owner ~= ''  and player:get_player_name() ~= owner )) then
		   return false;
		end

		return true;
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		
		if( player and player:get_player_name() ~= meta:get_string('owner' )) then
			return 0
		end
		
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( player and player:get_player_name() ~= meta:get_string('owner' )) then
			return 0;
		end
		
		if( listname=='hammer' and stack and string.sub( stack:get_name(), 1, 15 ) ~= 'cottages:hammer' ) then
			return 0;
		end
		
		if( listname=='input'
		 and( stack:get_wear() == 0
			or stack:get_name() == 'technic:water_can' 
			or stack:get_name() == 'technic:lava_can'
			or string.sub(stack:get_name(), 1, 8) == 'shooter:' )) then

			minetest.chat_send_player( player:get_player_name(), 'The workpiece slot is for damaged tools only.');
			return 0;
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
                if( player and player:get_player_name() ~= meta:get_string('owner' )) then
                        return 0
		end
		return stack:get_count()
	end,


	on_punch = function(pos, node, puncher)
		if( not( pos ) or not( node ) or not( puncher )) then
			return;
		end

		-- only punching with the hammer is supposed to work
		local wielded = puncher:get_wielded_item();
		if( not( wielded ) or not( wielded:get_name() )
			or string.sub( wielded:get_name(), 1, 15 ) ~= 'cottages:hammer' ) then
 			return
		end
		
		local name = puncher:get_player_name()

		local meta = minetest.env:get_meta(pos)
		local inv  = meta:get_inventory()

		local input = inv:get_stack('input',1);

		-- no input
		if ( not( input ) or input:is_empty() ) then return end

		-- only tools can be repaired
		local input_name = input:get_name()
		if ( input_name == 'technic:water_can'
				or input_name == 'technic:lava_can'
				or input_name == 'utechnic:chainsaw'
				or string.sub( input_name, 1, 15 ) == 'cottages:hammer'
				or input_name == 'fake_fire:flint_and_steel'
				or string.sub( input_name, 1, 8 ) == 'shooter:' )
		then
			minetest.chat_send_player( name, 'The workpiece slot is for damaged tools only.');
			return
		end
		
		-- recognize hammer type
		local tool = string.sub( wielded:get_name(), 10 )
		if ( tool == '' or HAMMERS[tool] == nil ) then return end

		-- tell the player when the job is done
		if(   input:get_wear() == 0 ) then
			minetest.log( 'action', name..' repaired ' .. input:get_name() .. ' using ' .. tool )
			minetest.chat_send_player( puncher:get_player_name(),
				'Your tool has been repaired successfully.');
			return;
		end

		-- do the actual repair
		input:add_wear( HAMMERS[tool].repair );
		--print('rep: '..HAMMERS[tool].repair)
		inv:set_stack("input", 1, input)

		-- damage the hammer
		wielded:add_wear( HAMMERS[tool].damage );
		--print('dmg: '..HAMMERS[tool].damage)
		puncher:set_wielded_item( wielded );

		if ( math.random( 0,1 ) == 1 ) then
			local v1 = puncher:get_look_dir()
			local p1 = puncher:getpos()

			if not v1 or not p1 then return end

			local pp = get_particle_pos(p1, v1, vector.distance(p1, pos))
			pp.y = pp.y + 1.3
			spawn_particles(pp)
		end

		-- do not spam too much
		if ( math.random( 1, 15 ) == 1 ) then
			minetest.chat_send_player( puncher:get_player_name(),
				'Your workpiece improves.');
		end
	end,
	is_ground_content = false,
})



---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = 'cottages:anvil',
	recipe = {
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'',                   'default:steel_ingot',''                   },
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'} },
})

-- the castle-mod has an anvil as well - with the same receipe. convert the two into each other
if ( minetest.get_modpath('castle') ~= nil ) then

  minetest.register_craft({
	output = 'cottages:anvil',
	recipe = {
		 {'castle:anvil'},
		},
  }) 

  minetest.register_craft({
	output = 'castle:anvil',
	recipe = {
		 {'cottages:anvil'},
		},
  }) 
end

