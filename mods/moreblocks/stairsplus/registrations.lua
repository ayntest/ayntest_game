local default_nodes = { -- Default stairs/slabs/panels/microblocks:
		"stone",
		"cobble",
		"mossycobble",
		"brick",
		"sandstone",
		"steelblock",
		"goldblock",
		"copperblock",
		"bronzeblock",
		"diamondblock",
		"desert_stone",
	--	"desert_cobble",
		"glass",
		"tree",
		"wood",
		"jungletree",
		"junglewood",
		"obsidian",
		"obsidian_glass",
		"stonebrick",
		"desert_stonebrick",
		"sandstonebrick"
}

function stairsplus.register_nodes( modname, nodes )
	for _, name in pairs(nodes) do
		local nodename = modname .. ':' .. name
		local ndef = minetest.registered_nodes[nodename]
		local groups = {}
		for k, v in pairs(ndef.groups)
			-- Ignore wood and stone groups to not make them usable in crafting:
			do if k ~= "wood" and k ~= "stone" then
				groups[k] = v
			end
		end
		local drop
		if type(ndef.drop) == "string" then
			drop = ndef.drop:sub(9)
		end
		if modname == 'wool' then
			name = 'wool_'..name
		end
		stairsplus:register_all("moreblocks", name, nodename, {
			description = ndef.description,
			drop = drop,
			groups = groups,
			sounds = ndef.sounds,
			tiles = ndef.tiles,
			sunlight_propagates = true,
		})
	end
end

stairsplus.register_nodes ( 'default', default_nodes )
