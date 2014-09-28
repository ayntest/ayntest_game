minetest.register_node("qr:guide", {
	description = "QR code (Guide)",
	drawtype = 'signlike',
	tiles = {'qr_guide.png'},
	wield_image = 'qr_guide.png',
	paramtype = "light",
	--is_ground_content = true,
	walkable = false,
	buildable_to = true,
	paramtype2 = 'wallmounted',
		selection_box = {
			type = "wallmounted",
		},
	groups = {not_in_creative_inventory=1, dig_immediate=2}
})
