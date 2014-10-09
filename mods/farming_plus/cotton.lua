--DEPRECATED

core.register_craftitem('farming_plus:cotton_seed', {
	description = 'Cotton Seeds',
	inventory_image = 'farming_cotton_seed.png',
	groups = { not_in_creative_inventory=1 },
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, 'farming:seed_cotton')
	end
})

core.register_craftitem('farming_plus:cotton', {
	description = 'Cotton (deprecated)',
	inventory_image = 'farming_cotton.png',
	groups = { not_in_creative_inventory=1 },
})

core.register_craft({
	output = "farming:cotton",
	type = "shapeless",
	recipe = { 'farming_plus:cotton' }
})

core.register_alias( 'farming_plus:cotton_1', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_2', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_3', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_4', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_5', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_6', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton_7', 'farming:cotton_3' )
core.register_alias( 'farming_plus:cotton', 'farming:cotton_3' )
