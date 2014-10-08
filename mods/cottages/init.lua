
-- Version: 2.0
-- Autor:   Sokomine
-- License: GPLv3

local load_time_start = os.clock()
cottages = {}

dofile(minetest.get_modpath('cottages')..'/nodes_furniture.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_historic.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_straw.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_anvil.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_doorlike.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_fences.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_roof.lua');
dofile(minetest.get_modpath('cottages')..'/nodes_barrel.lua');

print(string.format('[cottages] loaded after ca. %.3fs', os.clock() - load_time_start))
