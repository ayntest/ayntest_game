minetest.register_craftitem("pie:piebatter", {
	description = "Cake batter",
	inventory_image = "pie_piebatter.png",
})

minetest.register_craftitem("pie:apiebatter", {
	description = "Applepiebatter",
	inventory_image = "pie_apiebatter.png",
})

minetest.register_craftitem("pie:amuffinbatter", {
	description = "Applemuffinbatter",
	inventory_image = "pie_amuffinbatter.png",
})

minetest.register_craftitem("pie:knife", {
	description = "Pie knife",
	inventory_image = "pie_knife.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

		local node = minetest.get_node(pointed_thing.under).name

		if test_pie(node) then
			minetest.chat_send_player(user:get_player_name(), "Can not eat a block!")
			return
		end

		if minetest.get_modpath("hud") then
         		local name = user:get_player_name()
         		local h = tonumber(hud.hunger[name])
			h=h+4
         		if h>30 then
            			minetest.chat_send_player(user:get_player_name(), "Cannot eat, not hungry")
            			return
			end
         		hud.hunger[name]=h
         		hud.set_hunger(user)
      		else
		        if user:get_hp() == 20 then
            			minetest.chat_send_player(user:get_player_name(), "Cannot eat, health full")
            			return
			end
         		user:set_hp(user:get_hp() + 4)
	      	end

		local pos = pointed_thing.under
		minetest.set_node(pos, {name=eat_pie(node)})
                minetest.chat_send_player(user:get_player_name(), "Nom!")
        end
})

minetest.register_craftitem("pie:applemuffin", {
	description = "Applemuffin",
	inventory_image = "pie_applemuffin.png",
	on_use = function(itemstack, user, pointed_thing)
		if user:get_hp() == 20 then
			minetest.chat_send_player(user:get_player_name(), "Can not eat a muffin with full health.")
			return
		end
		minetest.item_eat(4)
	end,
--	on_place = function(itemstack, placer, pointed_thing)
--	end,
})
