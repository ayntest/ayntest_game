core.register_craft({
	output = 'hydro:growlamp',
	recipe = {
		{'default:glass', 'default:torch','default:glass'},
		{'default:glass', 'default:torch','default:glass'},
		{'default:glass', 'default:torch','default:glass'},
	}
})

core.register_craft({
	output = 'hydro:promix 6',
	recipe = {
		{'', 'default:clay_lump',''},
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})

core.register_craft({
	output = 'hydro:wine',
	recipe = {
		{'default:glass', 'hydro:grapes','default:glass'},
		{'default:glass', 'hydro:grapes','default:glass'},
		{'default:glass', 'hydro:grapes','default:glass'},
	}
})

core.register_craft({
	output = "hydro:coffeecup",
	recipe = {
		{'','',''},
		{'default:clay_lump','hydro:roastedcoffee','default:clay_lump'},
		{'','default:clay_lump',''},
	}
})

core.register_craft({
	type = "cooking",
	output = "hydro:roastedcoffee",
	recipe = "hydro:coffee",
})

core.register_craft({
	type = 'fuel',
	recipe = 'hydro:rosebush',
	burntime = 3,
})
