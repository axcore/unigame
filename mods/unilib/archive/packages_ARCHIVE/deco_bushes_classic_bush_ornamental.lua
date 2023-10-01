---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_active_spawner({
    spawn_delay = 3600,
    spawn_plants = bushes_classic.spawn_list,
    avoid_radius = 10,
    spawn_chance = 100,
    spawn_surfaces = {
        "default:dirt_with_grass",
        "woodsoils:dirt_with_leaves_1",
        "woodsoils:grass_with_leaves_1",
        "woodsoils:grass_with_leaves_2",
        "farming:soil",
        "farming:soil_wet"
    },
    avoid_nodes = {"group:bush"},
    seed_diff = 545342534, -- chosen by a fair mashing of the keyboard - guaranteed to be random :P
    plantlife_limit = -0.1,
    light_min = 10,
    temp_min = 0.15, -- approx 20C
    temp_max = -0.15, -- approx 35C
    humidity_min = 0, -- 50% RH
    humidity_max = -1, -- 100% RH
})
]]--
