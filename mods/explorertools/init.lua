--Explorer Tools version 1.1

--This code was written by Kilarin (Donald Hines) and his son Jesse Hines
--License:CC0, you can do whatever you wish with it.


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
    local success
    --attempt to place stack where tool was pointed
    stack, success = minetest.item_place(stack, player, pointed)
    if success then  --if item was placed, put modified stack back in inv
      inv:set_stack("main", idx, stack)
    end --success
  end --pointed ~= nil
end --function explorertools_place

---
---Explorer Tools register recipes
---


--we put the recipies inside an if checking for default so that
--in the unlikely case someone is running this without default,
--they still could.  they would just have to use /giveme or creative
--mode to get the tools
if minetest.get_modpath("default") then
	minetest.register_craft({
		  output = 'explorertools:pick_explorer',
	recipe = {
	  {'default:diamond', 'default:diamond', 'default:diamond'},
	  {'', 'default:mese_crystal_fragment', ''},
	  {'', 'group:stick', ''},
	}
	})

	minetest.register_craft({
	output = 'explorertools:axe_explorer',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:mese_crystal_fragment'},
		{'', 'group:stick'},
	}
	})

	minetest.register_craft({
	output = 'explorertools:shovel_explorer',
	recipe = {
		{'default:diamond'},
		{'default:mese_crystal_fragment'},
		{'group:stick'},
	}
	})
end --if default exists register recipes


---
---Explorer Tools Register Tools
---

minetest.register_tool("explorertools:pick_explorer", {
	description = "Explorer Pickaxe",
	inventory_image = "explorerpick.png",
	tool_capabilities = {
	full_punch_interval = 0.9,
	max_drop_level=3,
	groupcaps={
		cracky={times={[1]=3.0, [2]=2.0, [3]=0.5}, uses=33, maxlevel=3}
	},
		damage_groups = {fleshy=5},
	},
	--on_place = explorertools_place
})


minetest.register_tool("explorertools:axe_explorer", {
	description = "Explorer Axe",
	inventory_image = "exploreraxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=33, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
	--on_place = explorertools_place
})


minetest.register_tool("explorertools:shovel_explorer", {
	description = "Explorer Shovel",
	inventory_image = "explorershovel.png",
	wield_image = "explorershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.60, [3]=0.40}, uses=33, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	--on_place = explorertools_place
})
