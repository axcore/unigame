---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- intro_sound.lua
--      Set up sound effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Default sound effect
---------------------------------------------------------------------------------------------------

function unilib.sound.generate_node(sound_table)

    -- This function can be called directly, or by any of the functions below

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "", gain = 1.0}
    sound_table.dug = sound_table.dug or
        {name = "unilib_dug_node", gain = 0.25}
    sound_table.place = sound_table.place or
        {name = "unilib_place_node_hard", gain = 1.0}

    return sound_table

end

---------------------------------------------------------------------------------------------------
-- Standard sound effects
---------------------------------------------------------------------------------------------------

function unilib.sound.generate_dirt(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_dirt_footstep", gain = 0.25}
    sound_table.dig = sound_table.dig or
            {name = "unilib_dig_crumbly", gain = 0.4}
    sound_table.dug = sound_table.dug or
            {name = "unilib_dirt_footstep", gain = 1.0}
    sound_table.place = sound_table.place or
            {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_glass(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_glass_footstep", gain = 0.3}
    sound_table.dig = sound_table.dig or
        {name = "unilib_glass_footstep", gain = 0.5}
    sound_table.dug = sound_table.dug or
        {name = "unilib_break_glass", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_gravel(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_gravel_footstep", gain = 0.25}
    sound_table.dig = sound_table.dig or
            {name = "unilib_gravel_dig", gain = 0.35}
    sound_table.dug = sound_table.dug or
            {name = "unilib_gravel_dug", gain = 1.0}
    sound_table.place = sound_table.place or
            {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_ice(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_ice_footstep", gain = 0.15}
    sound_table.dig = sound_table.dig or
        {name = "unilib_ice_dig", gain = 0.5}
    sound_table.dug = sound_table.dug or
        {name = "unilib_ice_dug", gain = 0.5}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_leaves(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_grass_footstep", gain = 0.45}
    sound_table.dug = sound_table.dug or
        {name = "unilib_grass_footstep", gain = 0.7}
    sound_table.place = sound_table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_metal(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_metal_footstep", gain = 0.2}
    sound_table.dig = sound_table.dig or
        {name = "unilib_dig_metal", gain = 0.5}
    sound_table.dug = sound_table.dug or
        {name = "unilib_dug_metal", gain = 0.5}
    sound_table.place = sound_table.place or
        {name = "unilib_place_node_metal", gain = 0.5}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_sand(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_sand_footstep", gain = 0.05}
    sound_table.dug = sound_table.dug or
        {name = "unilib_sand_footstep", gain = 0.15}
    sound_table.place = sound_table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_snow(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_snow_footstep", gain = 0.2}
    sound_table.dig = sound_table.dig or
        {name = "unilib_snow_footstep", gain = 0.3}
    sound_table.dug = sound_table.dug or
        {name = "unilib_snow_footstep", gain = 0.3}
    sound_table.place = sound_table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_stone(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_hard_footstep", gain = 0.2}
    sound_table.dug = sound_table.dug or
        {name = "unilib_hard_footstep", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_water(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
        {name = "unilib_water_footstep", gain = 0.2}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_wood(sound_table)

    -- Adapted from minetest_game/default

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_wood_footstep", gain = 0.15}
    sound_table.dig = sound_table.dig or
            {name = "unilib_dig_choppy", gain = 0.4}
    sound_table.dug = sound_table.dug or
            {name = "unilib_wood_footstep", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.sound.generate_wool(sound_table)

    -- Adapted from stairs_redo/init.lua

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_wool_footstep", gain = 1.0}
    sound_table.dug = sound_table.dug or
            {name = "unilib_wool_footstep", gain = 0.25}
    sound_table.place = sound_table.place or
            {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

---------------------------------------------------------------------------------------------------
-- Compatibility functions
---------------------------------------------------------------------------------------------------

-- These functions have almost the same names as those used in minetest_game, so they can be used to
--      quickly import code from other mods
-- (e.g. compare default.node_sound_default(), default.node_sound_dirt_defaults() etc)

function unilib.node_sound_defaults(...)
    return unilib.sound.generate_node(...)
end

function unilib.node_sound_dirt_defaults(...)
    return unilib.sound.generate_dirt(...)
end

function unilib.node_sound_glass_defaults(...)
    return unilib.sound.generate_glass(...)
end

function unilib.node_sound_ice_defaults(...)
    return unilib.sound.generate_ice(...)
end

function unilib.node_sound_gravel_defaults(...)
    return unilib.sound.generate_gravel(...)
end

function unilib.node_sound_leaves_defaults(...)
    return unilib.sound.generate_leaves(...)
end

function unilib.node_sound_metal_defaults(...)
    return unilib.sound.generate_metal(...)
end

function unilib.node_sound_sand_defaults(...)
    return unilib.sound.generate_sand(...)
end

function unilib.node_sound_snow_defaults(...)
    return unilib.sound.generate_snow(...)
end

function unilib.node_sound_stone_defaults(...)
    return unilib.sound.generate_stone(...)
end

function unilib.node_sound_water_defaults(...)
    return unilib.sound.generate_water(...)
end

function unilib.node_sound_wood_defaults(...)
    return unilib.sound.generate_wood(...)
end

function unilib.node_sound_wool_defaults(...)
    return unilib.sound.generate_wool(...)
end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Store the definition table for each standard sound effect in a global variable
--      (unilib.global.sound_table)
-- When nodes specify a sound effect, they can just look up the definition table, rather than
--      creating a new table from scratch (as most Minetest mods tend to do)
-- If required, the functions above can be called directly instead. They behave in exactly the same
--      way as the corresponding functions in minetest_game/default

unilib.global.sound_table.node = unilib.sound.generate_node()

unilib.global.sound_table.dirt = unilib.sound.generate_dirt()
unilib.global.sound_table.glass = unilib.sound.generate_glass()
unilib.global.sound_table.ice = unilib.sound.generate_ice()
unilib.global.sound_table.gravel = unilib.sound.generate_gravel()
unilib.global.sound_table.leaves = unilib.sound.generate_leaves()
unilib.global.sound_table.metal = unilib.sound.generate_metal()
unilib.global.sound_table.sand = unilib.sound.generate_sand()
unilib.global.sound_table.snow = unilib.sound.generate_snow()
unilib.global.sound_table.stone = unilib.sound.generate_stone()
unilib.global.sound_table.water = unilib.sound.generate_water()
unilib.global.sound_table.wood = unilib.sound.generate_wood()
unilib.global.sound_table.wool = unilib.sound.generate_wool()
