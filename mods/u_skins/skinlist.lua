u_skins.list = {}
u_skins.meta = {}

local id = 1
local internal_id = 1
local fetched_skip = 0
while fetched_skip < 40 do
	local name = "character_"..id
	local file = io.open(u_skins.modpath.."/meta/"..name..".txt", "r")
	if file then
		local data = string.split(file:read("*all"), "\n", 3)
		file:close()
		
		u_skins.list[internal_id] = name
		u_skins.meta[name] = {}
		u_skins.meta[name].name = data[1]
		u_skins.meta[name].author = data[2]
		u_skins.meta[name].license = data[3]
		u_skins.meta[name].description = "" --what's that??
		u_skins.meta[name].gender = data[6] -- 1 means female (unused)
		
		if ( data[5] == 'true' or data[3] ~= '?' ) then -- if it's not hidden
			fetched_skip = 0
			internal_id = internal_id + 1
		else
			print('skipped hidden skin ' .. id .. ' (' .. data[1] .. ')' )
		end
	end
	
	fetched_skip = fetched_skip + 1
	id = id + 1
end
