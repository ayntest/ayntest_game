local inbox = {}

--[[
TODO
* Different node_box and texture for empty mailbox
]]

minetest.register_craft({
	output ="inbox:empty",
	recipe = {
		{"","default:steel_ingot",""},
		{"default:steel_ingot","","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"}
	}
})

minetest.register_craft({
	output ="inbox:mailbox_empty",
	recipe = {
		{'dye:blue', "default:steel_ingot", 'dye:blue'},
		{"default:steel_ingot", '', "default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"}
	}
})

minetest.register_node("inbox:empty", {
  paramtype = "light",
  drawtype = "nodebox",
  node_box = { 
    type = "fixed",
    fixed = {
      {-4/12, -6/12, -6/12, 4/12, 0/12, 6/12},
      {-3/12, 0/12, -6/12, 3/12, 2/12, 6/12},
      {3/12, 0/12, -4/12, 4/12, 5/12, -2/12},
      {3/12, 3/12, -2/12, 4/12, 5/12, 0/12}
    }
  },
  description = "Mailbox",
  tiles = {"inbox_top.png", "inbox_bottom.png", "inbox_east.png",
    "inbox_west.png", "inbox_back.png", "inbox_front.png"},
  paramtype2 = "facedir",
  groups = {choppy=2,oddly_breakable_by_hand=2},
  sounds = default.node_sound_wood_defaults(),
  after_place_node = function(pos, placer, itemstack)
    local meta = minetest.get_meta(pos)
    local owner = placer:get_player_name()
    meta:set_string("owner", owner)
    meta:set_string("infotext", owner.."'s Mailbox")
    local inv = meta:get_inventory()
    inv:set_size("main", 8*4)
    inv:set_size("drop", 1)
  end,
  on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.get_meta(pos)
    local player = clicker:get_player_name()
    local owner  = meta:get_string("owner")
    local meta = minetest.get_meta(pos)
    if owner == player or minetest.check_player_privs(player, {server=true}) then
      minetest.show_formspec(
        clicker:get_player_name(),
        "default:chest_locked",
        inbox.get_inbox_formspec(pos))
    else
      minetest.show_formspec(
        clicker:get_player_name(),
        "default:chest_locked",
        inbox.get_inbox_insert_formspec(pos))
    end
  end,
  can_dig = function(pos,player)
    local meta = minetest.get_meta(pos);
    local owner = meta:get_string("owner")
    local inv = meta:get_inventory()
    local name = player:get_player_name()
    return ( name == owner or minetest.check_player_privs(name, {server=true}) ) and inv:is_empty("main")
  end,
  on_metadata_inventory_put = function(pos, listname, index, stack, player)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if listname == "drop" and inv:room_for_item("main", stack) then
      inv:remove_item("drop", stack)
      inv:add_item("main", stack)
    end
  end,
  allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	if  minetest.check_player_privs(player:get_player_name(), {server=true}) then
		return -1
	end
	if listname == "main" then
	  return 0
	end
	if listname == "drop" then
	  local meta = minetest.get_meta(pos)
	  local inv = meta:get_inventory()
	  if inv:room_for_item("main", stack) then
		return -1
	  else
		return 0
	  end
	end
  end,
})

minetest.register_node("inbox:mailbox_empty", {
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { 
	type = "fixed",
	fixed = {
	  {-4/12, -6/12, -6/12, 4/12, 0/12, 6/12},
	  {-3/12, 0/12, -6/12, 3/12, 2/12, 6/12},
	  {3/12, 0/12, -4/12, 4/12, 5/12, -2/12},
	  {3/12, 3/12, -2/12, 4/12, 5/12, 0/12}
	}
	},
	description = "Letter Mailbox",
	tiles = {"mailbox_top.png", "mailbox_bottom.png", "mailbox_east.png",
	"mailbox_west.png", "mailbox_back.png", "mailbox_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", owner.."'s Letter Mailbox")
		local inv = meta:get_inventory()
		inv:set_size("main", 10*5)
		inv:set_size("drop", 1)
	end,
	
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local player = clicker:get_player_name()
		local owner  = meta:get_string("owner")
		local meta = minetest.get_meta(pos)
		if owner == player or minetest.check_player_privs(player, {server=true}) then
		  minetest.show_formspec(
			clicker:get_player_name(),
			"default:chest_locked",
			inbox.get_mailbox_formspec(pos))
		else
		  minetest.show_formspec(
			clicker:get_player_name(),
			"default:chest_locked",
			inbox.get_inbox_insert_formspec(pos))
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		return ( name == owner or minetest.check_player_privs(name, {server=true}) ) and inv:is_empty("main")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "drop" and inv:room_for_item("main", stack) then
		  inv:remove_item("drop", stack)
		  inv:add_item("main", stack)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if  minetest.check_player_privs(player:get_player_name(), {server=true}) then
			return -1
		end
		if listname == "main" then
		  return 0
		end
		if listname == "drop" then
		  local meta = minetest.get_meta(pos)
		  local inv = meta:get_inventory()
		  if inv:room_for_item("main", stack) and stack:get_name() == 'memorandum:letter' then
			return -1
		  else
			return 0
		  end
		end
	end,
})

function inbox.get_mailbox_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[10,10]"..
		"list[nodemeta:".. spos .. ";main;0,0;10,5;]"..
		"list[current_player;main;1,6;8,4;]"
	return formspec
end

function inbox.get_inbox_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:".. spos .. ";main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

function inbox.get_inbox_insert_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:".. spos .. ";drop;3.5,2;1,1;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

print("[Mod] Inbox Loaded!")
