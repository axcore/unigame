---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_convert.lua
--      Stair name conversion functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Stair name conversion functions
---------------------------------------------------------------------------------------------------

function unilib.stairs._convert_simple(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding simple
    --      stair node (e.g. "unilib:stone_ordinary_stair_simple")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.global.add_stairs_any_flag then
        return full_name .. "_stair_simple"
    else
        return full_name
    end

end

function unilib.stairs._convert_inner(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding inner
    --      stair node (e.g. "unilib:stone_ordinary_stair_inner")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.global.add_stairs_any_flag then
        return full_name .. "_stair_inner"
    else
        return full_name
    end

end

function unilib.stairs._convert_outer(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding outer
    --      stair node (e.g. "unilib:stone_ordinary_stair_outer")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.global.add_stairs_any_flag then
        return full_name .. "_stair_outer"
    else
        return full_name
    end

end

function unilib.stairs._convert_slab(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding slab
    --      stair node (e.g. "unilib:stone_ordinary_stair_slab")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.global.add_stairs_any_flag then
        return full_name .. "_stair_slab"
    else
        return full_name
    end

end
