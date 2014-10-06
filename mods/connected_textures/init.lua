local load_time_start = os.clock()
local function connect_glass(node, img)
	local tmp = core.registered_nodes[node]
	if not tmp then
		return
	end
	tmp.tiles = img
	tmp.drawtype = "glasslike_framed"
	core.register_node(":"..node, tmp)
end

local d_glass_list = {
	{"glass", {"default_glass.png", "connected_textures_glass_stripes.png"}},
	{"obsidian_glass", {"default_obsidian_glass.png", "connected_textures_invisible.png"}}
}

for _,i in ipairs(d_glass_list) do
	connect_glass("default:"..i[1], i[2])
end

if core.get_modpath("moreblocks") then

	local m_glass_list = {
		{'iron_glass', {'moreblocks_iron_glass.png', 'connected_textures_iron_glass_stripes.png'}},
		{'coal_glass', {'moreblocks_coal_glass.png', 'connected_textures_coal_glass_stripes.png'}},
		{'clean_glass', {'moreblocks_clean_glass.png', 'connected_textures_invisible.png'}},
		{'trap_glass', {'moreblocks_trap_glass.png', 'connected_textures_glass_stripes.png'}},
		{'glow_glass', {'moreblocks_glow_glass.png', 'connected_textures_glow_glass_stripes.png'}},
		{'super_glow_glass', {'moreblocks_super_glow_glass.png', 'connected_textures_glow_glass_stripes.png'}},
	}

	for _,i in ipairs(m_glass_list) do
		connect_glass("moreblocks:"..i[1], i[2])
	end

end

core.register_node(":default:ice", {
	description = "Ice",
	tiles = {"connected_textures_ice.png"},
	is_ground_content = true,
	use_texture_alpha = true,
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})
print(string.format("[connected_textures] loaded after ca. %.2fs", os.clock() - load_time_start))
