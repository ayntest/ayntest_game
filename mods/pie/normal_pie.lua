minetest.register_node("pie:pie_0", {
	description = "Pie",
	paramtype = "light",
	tiles = {
		"pie_pietop.png", 
		"pie_piebottom.png", 
		"pie_pieside.png", 
		"pie_pieside.png", 
		"pie_pieside.png", 
		"pie_pieside.png"
		},
	groups = {crumbly=3},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.45, 0.45, -0.17, 0.45},
			},
		},
})

minetest.register_node("pie:pie_1", {
	description = "3/4 pie",
	paramtype = "light",
	tiles = {
                "pie_pietop.png",
                "pie_piebottom.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_piebottom.png"
                },
        groups = {crumbly=3},
	drawtype = "nodebox",
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.45, -0.5, -0.25, 0.45, -0.17, 0.45},
                        },
                },
})

minetest.register_node("pie:pie_2", {
        description = "half pie",
        paramtype = "light",
        tiles = {
                "pie_pietop.png",
                "pie_piebottom.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_piebottom.png"
                },
        groups = {crumbly=3},
	drawtype = "nodebox",
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.45, -0.5, 0.0, 0.45, -0.17, 0.45},
                        },
                },
})

minetest.register_node("pie:pie_3", {
        description = "Piece of pie",
        paramtype = "light",
        tiles = {
                "pie_pietop.png",
                "pie_piebottom.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_pieside.png",
                "pie_piebottom.png"
                },
        groups = {crumbly=3},
        drawtype = "nodebox",  
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.45, -0.5, 0.25, 0.45, -0.17, 0.45},
                        },
                },
})
