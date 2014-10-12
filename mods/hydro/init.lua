local load_time_start = os.clock()

local HYDRO_GROW_INTERVAL = 180
local PLANTS = {
	tomato = {name='tomato', description="Tomato", growtype='growtall', give_on_harvest='farming_plus:tomato_item'},
	peas = {name='peas', description="Peas", growtype='growtall'},
	habanero = {name='habanero', description="Habanero", growtype='growtall'},
	grapes = {name='grapes', description="Grapes", growtype='permaculture'},
	coffee = {name='coffee', description="Coffee", growtype='permaculture'},
	roses = {name='roses', description="Roses", growtype='growtall',give_on_harvest='hydro:rosebush'},
	broses = {name='broses', description="Roses (Blue)", growtype='growtall',give_on_harvest='hydro:rosebush_blue'},
	proses = {name='proses', description="Roses (Pink)", growtype='growtall',give_on_harvest='hydro:rosebush_pink'},
	vroses = {name='vroses', description="Roses (Violet)", growtype='growtall',give_on_harvest='hydro:rosebush_violet'},
	yroses = {name='yroses', description="Roses (Yellow)", growtype='growtall',give_on_harvest='hydro:rosebush_yellow'},
	wroses = {name='wroses', description="Roses (White)", growtype='growtall',give_on_harvest='hydro:rosebush_white'}
}

core.register_node("hydro:wine", {
	description = 'Wine Bottle',
	drawtype = 'nodebox',
	tiles = {
		'hydro_wine_top.png',
		'hydro_bottle_wine_sides.png'
	},
	inventory_image = 'hydro_bottle_wine_inv.png',
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
			{-.022, -.12, -.022, .022, -0.1, .022}, -- wider upper
			{-.02, -.25, -.02, .02, -0.1, .02}, -- upper
			{-.045, -.5, -.045, .045, -.22, .045}, -- base
		}
	},
	sounds = default.node_sound_glass_defaults(),
	on_use = core.item_eat(1)
})

core.register_node("hydro:coffeecup", {
	description = 'Coffee Cup',
	drawtype = "plantlike",
	tiles = {"hydro_coffeecup.png"},
	inventory_image = "hydro_coffeecup.png",
	wield_image = "hydro_coffeecup.png",
	use_texture_alpha = true,
	paramtype = "light",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	walkable = false,
	on_use = core.item_eat(2)
})

core.register_node("hydro:growlamp", {
	description = "Growlamp",
	drawtype = 'nodebox',
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16,	-7/16,	-1/16,	1/16,	8/16,	1/16},
			{-2/16,	3/16,	-2/16,	2/16,	6/16,	2/16},
			{-3/16,	-6/16,	-2/16,	3/16,	3/16,	2/16},
			{-2/16,	-6/16,	-3/16,	2/16,	3/16,	3/16},
		}
	},
	tiles = {"hydro_growlamp_top.png", "hydro_growlamp_bottom.png", "hydro_growlamp_side.png"},
	--inventory_image = "hydro_growlamp_side.png",
	paramtype = "light",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15,
	groups = {
		snappy=2,
		cracky=3,
		oddly_breakable_by_hand=3,
		attached_node=1
	},
	sounds = default.node_sound_glass_defaults(),
	node_placement_prediction = "hydro:coffeecup",
})

core.on_place = core.on_place or function(name, func)
	local previous_on_place = core.registered_nodes[name].on_place
	core.override_item(name, {
		on_place = function(itemstack, placer, pointed_thing)
			if func(itemstack, placer, pointed_thing) then
				return previous_on_place(itemstack, placer, pointed_thing)
			end
		end
	})
end

core.on_place("hydro:growlamp", function(itemstack, placer, pointed_thing)
	if not pointed_thing then
		return
	end
	local pos = core.get_pointed_thing_position(pointed_thing, true)
	if not pos then
		return
	end
	local nd_above = core.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
	local nd_above_info = core.registered_nodes[nd_above]
	if nd_above == "air"
	or nd_above == "hydro:growlamp"
	or not nd_above_info.walkable
	or nd_above_info.buildable_to then
		return
	end
	return true
end)

core.register_node("hydro:promix", {
	description = "Promix",
	tiles = {"hydro_promix.png"},
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
})
core.register_node("hydro:roastedcoffee", {
	description = "Roasted Coffee",
	tiles = {"hydro_roastedcoffee.png"},
	inventory_image = core.inventorycube("hydro_roastedcoffee.png"),
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})
core.register_node("hydro:rosebush", {
	description = "Rose Bush",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_white", {
	description = "Rose Bush (White)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_white.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_yellow", {
	description = "Rose Bush (Yellow)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_yellow.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_violet", {
	description = "Rose Bush (Violet)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_violet.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_blue", {
	description = "Rose Bush (Blue)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_blue.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("hydro:rosebush_pink", {
	description = "Rose Bush (Pink)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"hydro_rosebush_pink.png"},
	paramtype = "light",
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

local get_plantname = {}		-- plants index by nodenames (tomato1, tomato2, seeds_tomato, etc..)
local get_plantbynumber = {}		-- plants index by number (for random select)
local get_wildplants = {}		-- wildplant nodenames (pop control)

for _,plant in pairs(PLANTS) do 
		--		define nodes
	local wild_plant = "hydro:wild_"..plant.name
	core.register_node(wild_plant, {
		description = "Wild "..plant.description.." Plant",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"hydro_wildplant.png"},
		paramtype = "light",
		walkable = false,
		groups = {
				attached_node=1,
				flammable=3,
				not_in_creative_inventory=1,
				snappy = 3
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'hydro:seeds_'..plant.name..' 4',
		selection_box = {
			type = "fixed",
			fixed = {-1/3, -1/2, -1/3, 1/3, 1/6, 1/3},
		},
	})
	core.register_node("hydro:seeds_"..plant.name, {
		description = plant.description.." Seeds",
		drawtype = 'signlike',
		tiles = {"hydro_seeds.png"},
		inventory_image = "hydro_seeds.png",
		wield_image = "hydro_seeds.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		is_ground_content = true,
		walkable = false,
		climbable = false,
		selection_box = {
			type = "wallmounted",
		},
		groups = {
				attached_node=1,
				choppy=2,
				not_in_creative_inventory=1,
				oddly_breakable_by_hand=3,
				snappy=2
			},
		legacy_wallmounted = true,
		sounds = default.node_sound_wood_defaults(),
	})
	core.register_node('hydro:seedlings_'..plant.name, {
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_seedlings.png' },
		inventory_image = 'hydro_seedlings.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = '',
	})
	core.register_node('hydro:sproutlings_' .. plant.name, {
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_sproutlings.png' },
		inventory_image = 'hydro_sproutlings.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = '',
	})
	core.register_node('hydro:'..plant.name..'1', {
		description = plant.description..' Plant (Young)',
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_'..plant.name..'1.png' },
		inventory_image = 'hydro_'..plant.name..'1.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = '',
	})

	core.register_node('hydro:'..plant.name..'2', {
		description = plant.description..' Plant (Youngish)',
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_'..plant.name..'2.png' },
		inventory_image = 'hydro_'..plant.name..'2.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = '',
	})
	core.register_node('hydro:'..plant.name..'3', {
		description = plant.description..' Plant (Fruitings)',
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_'..plant.name..'3.png' },
		inventory_image = 'hydro_'..plant.name..'3.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		drop = '',
	})
	

	local harvest = 'hydro:'..plant.name
	if plant.give_on_harvest then
		harvest = plant.give_on_harvest
	end
	
	local after_dig_node
	if plant.growtype == 'permaculture' then
		plant.growtype = 'growshort'
		after_dig_node = function(pos)
			core.add_node(pos, {name='hydro:'..plant.name..'1'})
		end

	end

	core.register_node('hydro:'..plant.name..'4', {
		description = plant.description..' Plant (Ripe)',
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tiles = { 'hydro_'..plant.name..'4.png' },
		inventory_image = 'hydro_'..plant.name..'4.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		furnace_burntime = 1,
		groups = {
				snappy = 3,
				not_in_creative_inventory=1
			},
		sounds = default.node_sound_leaves_defaults(),
		after_dig_node = after_dig_node,
		drop = { 
				items = {
					{	items = {'hydro:seeds_'..plant.name..' 4'},
						rarity = 4,
					},
					{
						items = {harvest..' 2'},
					}
				}
		},

	})
	if not plant.give_on_harvest then
		core.register_node("hydro:"..plant.name, {
			description = plant.name,
			drawtype = "plantlike",
			visual_scale = 1.0,
			tiles = {"hydro_"..plant.name..".png"},
			inventory_image = "hydro_"..plant.name..".png",
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			groups = {
				fleshy=3,
				dig_immediate=3,
				flammable=2
				},
			on_use = core.item_eat(4),
			sounds = default.node_sound_defaults(),
		})
	end
	table.insert(get_wildplants, wild_plant)
	table.insert(get_plantbynumber, plant.name)
	get_plantname["hydro:"..plant.name.."4"] = plant.name
	get_plantname["hydro:"..plant.name.."3"] = plant.name
	get_plantname["hydro:"..plant.name.."2"] = plant.name
	get_plantname["hydro:"..plant.name.."1"] = plant.name
	get_plantname['hydro:sproutlings_'..plant.name] = plant.name
	get_plantname['hydro:seedlings_'..plant.name] =  plant.name
	get_plantname['hydro:seeds_'..plant.name] = plant.name
end

--		GROW (TALL) FUNCTION
local function grow_plant(plantname, nodename, pos, tall)
	local name, above
	if nodename == 'hydro:'..plantname..'3' 			then
		name = plantname.."4"
		above = true
	elseif nodename == 'hydro:'..plantname..'2' 		then
		name = plantname.."3"
		above = true
	elseif nodename == 'hydro:'..plantname..'1' 		then
		name = plantname.."2"
		above = true
	elseif nodename =='hydro:sproutlings_'..plantname 	then
		name = plantname.."1"
	elseif nodename == 'hydro:seedlings_'..plantname 	then
		name = "sproutlings_"..plantname
	elseif nodename == 'hydro:seeds_'..plantname 		then
		name = "seedlings_"..plantname
	else
		return
	end
	core.add_node(pos, {name="hydro:"..name})
	if above
	and tall then
		core.add_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="hydro:"..name})
	end
end

--		WILD PLANTS/SEEDS GENERATING
local function get_random(pos, seed)
	return PseudoRandom(math.abs(pos.x+pos.y*3+pos.z*5)+seed)
end

core.register_abm({
	nodenames = { "default:dirt_with_grass" },
	interval = 1200,
	chance = 80,
	action = function(p, node)
		local pr = get_random(p, 17)
		if pr:next(1,200) ~= 1 then
			return
		end
		p.y = p.y+1
		local is_air = core.get_node_or_nil(p)
		if is_air
		and is_air.name == 'air' then
			local count = table.getn(get_plantbynumber)
			local random_plant = math.random(1, count)
			local nodename = "hydro:wild_"..get_plantbynumber[random_plant]
			if nodename ~= "hydro:wild_rubberplant" then
				core.add_node(p, {name=nodename})
			end
		end
	end
})

--		GROWING
core.register_abm({
	nodenames = { "hydro:growlamp" },
	interval = HYDRO_GROW_INTERVAL,
	chance = 1,
	action = function(pos, node)
		if core.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air"
		or core.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "air" then
			return
		end
		for i = -1,1 do
			for j = -1,1 do
				local p = {x=pos.x+j, y=pos.y, z=pos.z+i}
				local water = core.get_node({x=p.x, y=p.y-5, z=p.z}).name
				local soil = core.get_node({x=p.x, y=p.y-4, z=p.z}).name
				if (water == 'default:water_source' or water == 'default:water_flowing')
				and ( soil == 'hydro:promix' or soil == 'farming:soil_wet' ) then
					local grow = core.get_node({x=p.x, y=p.y-3, z=p.z}).name
					local curplant = get_plantname[grow]
					if curplant then
						local growtype = PLANTS[curplant].growtype
						local tall
						if growtype == 'growtall' then
							tall = true
						end
						grow_plant(curplant, grow, {x=p.x, y=p.y-3, z=p.z}, tall)
					end
				end
			end
		end
	end
})
dofile( core.get_modpath('hydro') .. '/crafting.lua' )

print(string.format('[hydro] loaded after ca. %.3fs', os.clock() - load_time_start))
