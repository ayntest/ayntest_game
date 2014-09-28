shooter = {
	time = 0,
	objects = {},
	rounds = {},
	shots = {},
	update_time = 0,
	reload_time = 0,
}

SHOOTER_ENABLE_GUNS = true
SHOOTER_ENABLE_FLARES = true
SHOOTER_ENABLE_HOOK = true
SHOOTER_ENABLE_GRENADES = true
SHOOTER_ENABLE_ROCKETS = true
SHOOTER_ENABLE_TURRETS = true
SHOOTER_ENABLE_CRAFTING = true
SHOOTER_ENABLE_PARTICLE_FX = true
SHOOTER_EXPLOSION_TEXTURE = "shooter_hit.png"
SHOOTER_ALLOW_NODES = true
SHOOTER_ALLOW_ENTITIES = false
SHOOTER_ALLOW_PLAYERS = true
SHOOTER_OBJECT_RELOAD_TIME = 1
SHOOTER_OBJECT_UPDATE_TIME = 0.25
SHOOTER_ROUNDS_UPDATE_TIME = 0.4
SHOOTER_PLAYER_OFFSET = {x=0, y=1, z=0}
SHOOTER_ENTITY_OFFSET = {x=0, y=0, z=0}
SHOOTER_ENTITIES = {
	"mobs:dirt_monster",
	"mobs:stone_monster",
	"mobs:sand_monster",
	"mobs:tree_monster",
	"mobs:sheep",
	"mobs:rat",
	"mobs:oerkki",
	"mobs:dungeon_master",
}

if minetest.is_singleplayer() == true then
	SHOOTER_ALLOW_ENTITIES = true
	SHOOTER_ALLOW_PLAYERS = false
end

local allowed_entities = {}
for _,v in ipairs(SHOOTER_ENTITIES) do
	allowed_entities[v] = 1
end

local modpath = minetest.get_modpath(minetest.get_current_modname())
local input = io.open(modpath.."/shooter.conf", "r")
if input then
	dofile(modpath.."/shooter.conf")
	input:close()
	input = nil
end

local function get_dot_product(v1, v2)
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

local function get_particle_pos(p, v, d)
	return vector.add(p, vector.multiply(v, {x=d, y=d, z=d}))
end

local function spawn_particles(pos, texture)
	if SHOOTER_ENABLE_PARTICLE_FX == true then
		if type(texture) ~= "string" then
			texture = SHOOTER_EXPLOSION_TEXTURE
		end
		local spread = {x=0.1, y=0.1, z=0.1}
		minetest.add_particlespawner(15, 0.3,
			vector.subtract(pos, spread), vector.add(pos, spread),
			{x=-1, y=1, z=-1}, {x=1, y=2, z=1},
			{x=-2, y=-2, z=-2}, {x=2, y=-2, z=2},
			0.1, 0.75, 1, 2, false, texture
		)
	end
end

local function is_valid_object(object)
	if object then
		if object:is_player() == true then
			return true
		end
		if SHOOTER_ALLOW_ENTITIES == true then
			local luaentity = object:get_luaentity()
			if luaentity then
				if luaentity.name then
					if allowed_entities[luaentity.name] then
						return true
					end
				end
			end
		end
	end
	return false
end

local function punch_node(pos, def)
	local node = minetest.get_node(pos)
	if not node then
		return
	end
	local item = minetest.registered_items[node.name]
	if not item then
		return
	end
	if item.groups then
		for k, v in pairs(def.groups) do
			local level = item.groups[k] or 0
			if level >= v then
				minetest.remove_node(pos)
				local sounds = item.sounds
				if item.sounds then
					local spec = item.sounds.dug
					if spec then
						spec.pos = pos
						minetest.sound_play(spec.name, spec)
					end
				end
				if item.tiles then
					return item.tiles[1]
				end
				break
			end
		end
	end
end

function shooter:process_round(round)
	local target = {object=nil, distance=10000}
	local p1 = round.pos
	local v1 = round.ray
	for _,ref in ipairs(shooter.objects) do
		local p2 = vector.add(ref.pos, ref.offset)
		if p1 and p2 and ref.name ~= round.name then
			local d = vector.distance(p1, p2)
			if d < round.def.step then
				local n = vector.multiply(v1, {x=-1, y=0, z=-1})
				local v2 = vector.subtract(p1, p2)
				local r1 = get_dot_product(n, v2)
				local r2 = get_dot_product(n, v1)
				if r2 ~= 0 then
					local t = -(r1 / r2)
					local td = vector.multiply(v1, {x=t, y=t, z=t})
					local pt = vector.add(p1, td)
					local pd = vector.subtract(pt, p2)
					if math.abs(pd.x) < ref.collisionbox[4] and
							math.abs(pd.y) < ref.collisionbox[5] and
							math.abs(pd.z) < ref.collisionbox[6] then
						target.object = ref.object
						target.pos = pt
						target.distance = d
					end
				end
			end
		end
	end
	if target.object and target.pos then
		local success, pos = minetest.line_of_sight(p1, target.pos, 1)
		if success then
			local user = minetest.get_player_by_name(round.name)
			if user then
				target.object:punch(user, nil, round.def.tool_caps, v1)
				spawn_particles(target.pos, SHOOTER_EXPLOSION_TEXTURE)
			end
			return 1
		elseif pos and SHOOTER_ALLOW_NODES == true then
			local texture = punch_node(pos, round.def)
			if texture then
				local pp = get_particle_pos(p1, v1, vector.distance(p1, pos))
				spawn_particles(pp, texture)
			end
			return 1
		end
	elseif SHOOTER_ALLOW_NODES == true then
		local d = round.def.step
		local p2 = vector.add(p1, vector.multiply(v1, {x=d, y=d, z=d}))
		local success, pos = minetest.line_of_sight(p1, p2, 1)
		if pos then
			local texture = punch_node(pos, round.def)
			if texture then
				local pp = get_particle_pos(p1, v1, vector.distance(p1, pos))
				spawn_particles(pp, texture)
			end
			return 1
		end
	end
end

function shooter:register_weapon(name, def)
	local shots = def.shots or 1
	local wear = math.ceil(65534 / def.rounds)
	local max_wear = (def.rounds - 1) * wear
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		on_use = function(itemstack, user, pointed_thing)
			-- prevent using without interact priv
			local user_privs = minetest.get_player_privs(user:get_player_name())
			if (user_privs['interact'] == false) then
				return
			end
			
			if itemstack:get_wear() < max_wear then
				def.spec.name = user:get_player_name()
				if shots > 1 then
					local step = def.spec.tool_caps.full_punch_interval
					for i = 0, step * (shots), step do
						minetest.after(i, function()
							shooter:fire_weapon(user, pointed_thing, def.spec)
						end)
					end
				else
					shooter:fire_weapon(user, pointed_thing, def.spec)
				end
				itemstack:add_wear(wear)
			else
				local inv = user:get_inventory()
				if inv then
					local stack = "shooter:ammo 1"
					if inv:contains_item("main", stack) then
						minetest.sound_play("shooter_reload", {object=user})
						inv:remove_item("main", stack)
						itemstack:replace(name.." 1 1")
					else
						minetest.sound_play("shooter_click", {object=user})
					end
				end
			end
			return itemstack
		end,
	})
end

function shooter:fire_weapon(user, pointed_thing, def)
	if shooter.shots[def.name] then
		if shooter.time < shooter.shots[def.name] then
			return
		end
	end
	shooter.shots[def.name] = shooter.time + def.tool_caps.full_punch_interval
	minetest.sound_play(def.sound, {object=user})
	local v1 = user:get_look_dir()
	local p1 = user:getpos()
	if not v1 or not p1 then
		return
	end
	minetest.add_particle({x=p1.x, y=p1.y + 1.6, z=p1.z},
		vector.multiply(v1, {x=30, y=30, z=30}),
		{x=0, y=0, z=0}, 0.5, 0.25,
		false, def.particle
	)
	if pointed_thing.type == "node" and SHOOTER_ALLOW_NODES == true then
		local pos = minetest.get_pointed_thing_position(pointed_thing, false)
		local texture = punch_node(pos, def)
		if texture then
			local pp = get_particle_pos(p1, v1, vector.distance(p1, pos))
			pp.y = pp.y + 1.75
			spawn_particles(pp, texture)
		end
	elseif pointed_thing.type == "object" then
		local object = pointed_thing.ref
		if is_valid_object(object) == true then
			object:punch(user, nil, def.tool_caps, v1)
			local p2 = object:getpos()
			local pp = get_particle_pos(p1, v1, vector.distance(p1, p2))
			pp.y = pp.y + 1.75
			spawn_particles(pp, SHOOTER_EXPLOSION_TEXTURE)
		end
	else
		shooter:update_objects()
		table.insert(shooter.rounds, {
			name = def.name,
			pos = vector.add(p1, {x=0, y=1.75, z=0}),
			ray = v1,
			dist = 0,
			def = def,
		})
	end
end

function shooter:load_objects()
	local objects = {}
	if SHOOTER_ALLOW_PLAYERS == true then
		local players = minetest.get_connected_players()
		for _,player in ipairs(players) do
			local pos = player:getpos()
			local name = player:get_player_name()
			local hp = player:get_hp() or 0
			if pos and name and hp > 0 then
				table.insert(objects, {
					name = name,
					object = player,
					pos = pos,
					collisionbox = {-0.25,-1.0,-0.25, 0.25, 0.8, 0.25},
					offset = SHOOTER_PLAYER_OFFSET,
				})
			end
		end
	end
	if SHOOTER_ALLOW_ENTITIES == true then
		for _,ref in pairs(minetest.luaentities) do
			if ref.object and ref.name then
				if allowed_entities[ref.name] then
					local pos = ref.object:getpos()
					local hp = ref.object:get_hp() or 0
					if pos and hp > 0 then
						local def = minetest.registered_entities[ref.name]
						table.insert(objects, {
							name = ref.name,
							object = ref.object,
							pos = pos,
							collisionbox = def.collisionbox,
							offset = SHOOTER_ENTITY_OFFSET,
						})
					end
				end
			end
		end
	end
	shooter.reload_time = shooter.time
	shooter.update_time = shooter.time
	shooter.objects = {}
	for _,v in ipairs(objects) do
		table.insert(shooter.objects, v)
	end
end

function shooter:update_objects()
	if shooter.time - shooter.reload_time > SHOOTER_OBJECT_RELOAD_TIME then
		shooter:load_objects()
	elseif shooter.time - shooter.update_time > SHOOTER_OBJECT_UPDATE_TIME then
		for i, ref in ipairs(shooter.objects) do
			if ref.object then
				local pos = ref.object:getpos()
				if pos then
					shooter.objects[i].pos = pos
				end
			else
				table.remove(shooter.objects, i)
			end
		end
		shooter.update_time = shooter.time
	end
end

function shooter:blast(pos, radius, fleshy, distance)
	local pos = vector.round(pos)
	local p1 = vector.subtract(pos, radius)
	local p2 = vector.add(pos, radius)
	minetest.sound_play("tnt_explode", {pos=pos, gain=1})
	if SHOOTER_ALLOW_NODES == true then
		minetest.set_node(pos, {name="tnt:boom"})
	end
	if SHOOTER_ENABLE_PARTICLE_FX == true then
		minetest.add_particlespawner(50, 0.1,
			p1, p2, {x=-0, y=-0, z=-0}, {x=0, y=0, z=0},
			{x=-0.5, y=5, z=-0.5}, {x=0.5, y=5, z=0.5},
			0.1, 1, 8, 15, false, "tnt_smoke.png"
		)
	end
	local objects = minetest.get_objects_inside_radius(pos, distance)
	for _,obj in ipairs(objects) do
		if (obj:is_player() and SHOOTER_ALLOW_PLAYERS == true) or
				(obj:get_luaentity() and SHOOTER_ALLOW_ENTITIES == true and
				obj:get_luaentity().name ~= "__builtin:item") then
			local obj_pos = obj:getpos()
			local dist = vector.distance(obj_pos, pos)
			local damage = (fleshy * 0.5 ^ dist) * 2
			if dist ~= 0 then
				obj_pos.y = obj_pos.y + 1.7
				blast_pos = {x=pos.x, y=pos.y + 4, z=pos.z}
				if minetest.line_of_sight(obj_pos, blast_pos, 1) then
					obj:punch(obj, 1.0, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy=damage},
					})
				end
			end
		end
	end
	if SHOOTER_ALLOW_NODES == false then
		return
	end
	local pr = PseudoRandom(os.time())
	local vm = VoxelManip()
	local min, max = vm:read_from_map(p1, p2)
	local area = VoxelArea:new({MinEdge=min, MaxEdge=max})
	local data = vm:get_data()
	local c_air = minetest.get_content_id("air")
	for z = -radius, radius do
		for y = -radius, radius do
			local vi = area:index(pos.x - radius, pos.y + y, pos.z + z)
			for x = -radius, radius do
				if (x * x) + (y * y) + (z * z) <=
						(radius * radius) + pr:next(-radius, radius) then
					data[vi] = c_air
				end
				vi = vi + 1
			end
		end
	end
	vm:set_data(data)
	vm:update_liquids()
	vm:write_to_map()
	vm:update_map()
end
