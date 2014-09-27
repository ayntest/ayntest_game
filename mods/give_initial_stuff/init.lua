minetest.register_on_newplayer(function(player)
	--print("on_newplayer")
	if minetest.setting_getbool("give_initial_stuff") then
		local name = player:get_player_name()
		if not name:find('Guest') then
			minetest.log("action", "Giving initial stuff to player "..name)
			player:get_inventory():add_item('main', 'default:pick_steel')
			player:get_inventory():add_item('main', 'default:shovel_steel')
			player:get_inventory():add_item('main', 'default:axe_steel')
			player:get_inventory():add_item('main', 'default:torch 10')
			player:get_inventory():add_item('main', 'default:chest_locked')
			player:get_inventory():add_item('main', 'farming_plus:orange_item 30')
		end
	end
end)

