test_pie = function(node)
	local t = {
		"pie:pie_0", "pie:pie_1", "pie:pie_2", "pie:pie_3",
		"pie:apie_0", "pie:apie_1", "pie:apie_2", "pie:apie_3"
		}

	for _, item in ipairs(t) do
		if node == item then
			return false
		end
	end
	return true
end

eat_pie = function(node)
	if node == "pie:pie_0" then
		return "pie:pie_1"
	elseif node == "pie:pie_1" then
		return "pie:pie_2"
	elseif node == "pie:pie_2" then
		return "pie:pie_3"
	elseif node == "pie:pie_3" then  
		return "air"
	elseif node == "pie:apie_0" then
		return "pie:apie_1"
	elseif node == "pie:apie_1" then
                return "pie:apie_2"
	elseif node == "pie:apie_2" then
                return "pie:apie_3"
	elseif node == "pie:apie_3" then
                return "air"
	end
end
