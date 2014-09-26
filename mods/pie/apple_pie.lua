minetest.register_node("pie:apie_0", {
        description = "Apple pie",
        paramtype = "light",
        tiles = {
                "pie_apietop.png",
                "pie_apiebottom.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside.png"
                },
        groups = {crumbly=3},
        drawtype = "nodebox",
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.45, -0.5, -0.45, 0.45, -0.17, 0.45},
                        {-0.12, -0.17, -0.12, 0.12, 0.0, 0.12},
			},
                },
})

minetest.register_node("pie:apie_1", {
        description = "3/4 apple pie",
        paramtype = "light",
        tiles = {
                "pie_apietop.png", 
                "pie_apiebottom.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside_s.png"
                },
        groups = {crumbly=3},
        drawtype = "nodebox",  
        node_box = {
                type = "fixed",
                fixed = { 
                        {-0.45, -0.5, -0.25, 0.45, -0.17, 0.45},
			{-0.12, -0.17, -0.12, 0.12, 0.0, 0.12},
                        },
                },
})

minetest.register_node("pie:apie_2", {
        description = "Half apple pie", 
        paramtype = "light",
        tiles = {
                "pie_apietop.png",
                "pie_apiebottom.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside_s2.png"
                },
        groups = {crumbly=3},
        drawtype = "nodebox",
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.45, -0.5, 0.0, 0.45, -0.17, 0.45},
			{-0.12, -0.17, 0.0, 0.12, 0.0, 0.12},
                        },  
                },
})

minetest.register_node("pie:apie_3", {
        description = "Piece of apple pie",
        paramtype = "light",
        tiles = {
                "pie_apietop.png",
                "pie_apiebottom.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apieside.png",
                "pie_apiebottom.png"
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
