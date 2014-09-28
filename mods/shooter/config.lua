-- Simple Shooter config example

-- Global Constants (defaults)

-- Enable basic guns (Pistol, Rifle, Shotgun, Machine Gun)
SHOOTER_ENABLE_GUNS = true

-- Enable Flare Gun
SHOOTER_ENABLE_FLARES = true

-- Enable Grappling Hook
SHOOTER_ENABLE_HOOK = false

-- Enable Grenades
SHOOTER_ENABLE_GRENADES = false

-- Enable Rocket Gun
SHOOTER_ENABLE_ROCKETS = false

-- Enable Turrret Gun
SHOOTER_ENABLE_TURRETS = false

-- Enable Crafting
SHOOTER_ENABLE_CRAFTING = true

-- Enable particle effects
SHOOTER_ENABLE_PARTICLE_FX = true

-- Particle texture used when a player or entity is hit
SHOOTER_EXPLOSION_TEXTURE = 'shooter_hit.png'

-- Allow node destruction
SHOOTER_ALLOW_NODES = false
-- FIXME make it work with landrush

-- Allow entities in multiplayer mode
SHOOTER_ALLOW_ENTITIES = true

-- Allow players in multiplayer mode
SHOOTER_ALLOW_PLAYERS = true

-- How often objects are fully reloaded
SHOOTER_OBJECT_RELOAD_TIME = 1

-- How often object positions are updated
SHOOTER_OBJECT_UPDATE_TIME = 0.25

-- How often rounds are processed
SHOOTER_ROUNDS_UPDATE_TIME = 0.4

-- Player collision box offset (may require adjustment for some games)
SHOOTER_PLAYER_OFFSET = {x=0, y=1, z=0}

-- Entity collision box offset (may require adjustment for other mobs)
SHOOTER_ENTITY_OFFSET = {x=0, y=0, z=0}

-- Shootable entities (default support for Simple Mobs)
SHOOTER_ENTITIES = {
	'zombies:zombie',
	'helicopter:heli',
--	'mobs:sand_monster',
	'mobs:tree_monster',
	'mobs:sheep',
	'mobs:rat',
	'mobs:oerkki',
--	'mobs:dungeon_master'
}

