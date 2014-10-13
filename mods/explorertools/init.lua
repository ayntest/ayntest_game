--Explorer Tools All version 1.1

--The original Explorer Tools code was written by Kilarin (Donald Hines) and
--his son Jesse Hines. 4aiman then created a version that instead of creating
--special explorer tools with their own recipie, gave this "place on rightclick"
--ability to every pick, axe, and shovel in the game.  This version is a slight
--modification of his version.
--License:GPLv3 http://gplv3.fsf.org/

---
---Function
---

--This function is for use when an explorertool is right clicked
--it finds the inventory item immediatly to the right of the explorertool
--and then places THAT item (if possible)
--
function explorertools_place(item, player, pointed)
	--find index of item to right of wielded tool
	--(could have gotten this directly from item I suppose, but this works fine)
	local idx = player:get_wield_index() + 1
	local inv = player:get_inventory()
	local stack = inv:get_stack("main", idx) --stack=stack to right of tool
	if pointed ~= nil then
		--attempt to place stack where tool was pointed
		stack = minetest.item_place(stack, player, pointed)
		inv:set_stack("main", idx, stack)
	end
end

---Explorer Tools definitions (DEPRECATED)
minetest.register_tool("explorertools:pick_explorer", {
	description = "Explorer Pickaxe",
	inventory_image = "explorerpick.png",
	tool_capabilities = {
	full_punch_interval = 0.9,
	max_drop_level=3,
	groupcaps={
		cracky={times={[1]=3.0, [2]=2.0, [3]=0.5}, uses=43, maxlevel=3}
	},
		damage_groups = {fleshy=5},
	},
	groups = { not_in_creative_inventory=1 }
})


minetest.register_tool("explorertools:axe_explorer", {
	description = "Explorer Axe",
	inventory_image = "exploreraxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=43, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
	groups = { not_in_creative_inventory=1 }
})


minetest.register_tool("explorertools:shovel_explorer", {
	description = "Explorer Shovel",
	inventory_image = "explorershovel.png",
	wield_image = "explorershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.60, [3]=0.40}, uses=43, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	groups = { not_in_creative_inventory=1 }
})
-- end of tool definitions

--loop through all defined tools, and if it is a pick, axe, shovel, or spade,
--change it's on_place function to be explorertools_place
for cou,def in pairs(minetest.registered_tools) do
	if def.name:find('pick')
		or def.name:find('axe')
		or def.name:find('shovel')
		or def.name:find('spade')
		then
		core.override_item( def.name, {on_place = explorertools_place,} )
	end
end
