---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- sounds.lua
--      Set up unilib standard sound effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Default sound effect
---------------------------------------------------------------------------------------------------

function unilib.node_sound_defaults(table)

    -- This function can be called directly, or by any of the functions below

    table = table or {}

    table.footstep = table.footstep or
        {name = "", gain = 1.0}
    table.dug = table.dug or
        {name = "unilib_dug_node", gain = 0.25}
    table.place = table.place or
        {name = "unilib_place_node_hard", gain = 1.0}

    return table

end

---------------------------------------------------------------------------------------------------
-- Standard sound effects
---------------------------------------------------------------------------------------------------

function unilib.node_sound_dirt_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_dirt_footstep", gain = 0.4}
    table.dug = table.dug or
        {name = "unilib_dirt_footstep", gain = 1.0}
    table.place = table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_glass_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_glass_footstep", gain = 0.3}
    table.dig = table.dig or
        {name = "unilib_glass_footstep", gain = 0.5}
    table.dug = table.dug or
        {name = "unilib_break_glass", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_gravel_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_gravel_footstep", gain = 0.4}
    table.dug = table.dug or
        {name = "unilib_gravel_footstep", gain = 1.0}
    table.place = table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_ice_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_ice_footstep", gain = 0.3}
    table.dig = table.dig or
        {name = "unilib_ice_dig", gain = 0.5}
    table.dug = table.dug or
        {name = "unilib_ice_dug", gain = 0.5}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_leaves_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_grass_footstep", gain = 0.45}
    table.dug = table.dug or
        {name = "unilib_grass_footstep", gain = 0.7}
    table.place = table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_metal_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_metal_footstep", gain = 0.4}
    table.dig = table.dig or
        {name = "unilib_dig_metal", gain = 0.5}
    table.dug = table.dug or
        {name = "unilib_dug_metal", gain = 0.5}
    table.place = table.place or
        {name = "unilib_place_node_metal", gain = 0.5}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_sand_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_sand_footstep", gain = 0.12}
    table.dug = table.dug or
        {name = "unilib_sand_footstep", gain = 0.24}
    table.place = table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_snow_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_snow_footstep", gain = 0.2}
    table.dig = table.dig or
        {name = "unilib_snow_footstep", gain = 0.3}
    table.dug = table.dug or
        {name = "unilib_snow_footstep", gain = 0.3}
    table.place = table.place or
        {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_stone_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_hard_footstep", gain = 0.3}
    table.dug = table.dug or
        {name = "unilib_hard_footstep", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_water_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_water_footstep", gain = 0.2}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_wood_defaults(table)

    -- Adapted from minetest_game/default

    table = table or {}

    table.footstep = table.footstep or
        {name = "unilib_wood_footstep", gain = 0.3}
    table.dug = table.dug or
        {name = "unilib_wood_footstep", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

function unilib.node_sound_wool_defaults(table)

    -- Adapted from stairs_redo/init.lua

    table = table or {}

    table.footstep = table.footstep or
            {name = "unilib_wool_footstep", gain = 1.0}
    table.dug = table.dug or
            {name = "unilib_wool_footstep", gain = 0.25}
    table.place = table.place or
            {name = "unilib_place_node", gain = 1.0}

    unilib.node_sound_defaults(table)

    return table

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Store the definition table for each standard sound effect in a global variable
--      (unilib.sound_table)
-- When nodes specify a sound effect, they can just look up the definition table, rather than
--      creating a new table from scratch (as most Minetest mods tend to do)
-- If required, the functions above can be called directly instead. They behave in exactly the same
--      way as the corresponding functions in minetest_game/default

unilib.sound_table.node = unilib.node_sound_defaults()

unilib.sound_table.dirt = unilib.node_sound_dirt_defaults()
unilib.sound_table.glass = unilib.node_sound_glass_defaults()
unilib.sound_table.ice = unilib.node_sound_ice_defaults()
unilib.sound_table.gravel = unilib.node_sound_gravel_defaults()
unilib.sound_table.leaves = unilib.node_sound_leaves_defaults()
unilib.sound_table.metal = unilib.node_sound_metal_defaults()
unilib.sound_table.sand = unilib.node_sound_sand_defaults()
unilib.sound_table.snow = unilib.node_sound_snow_defaults()
unilib.sound_table.stone = unilib.node_sound_stone_defaults()
unilib.sound_table.water = unilib.node_sound_water_defaults()
unilib.sound_table.wood = unilib.node_sound_wood_defaults()
unilib.sound_table.wool = unilib.node_sound_wool_defaults()
