---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- bushes_grow.lua
--      Grow bush saplings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Grow bush saplings
---------------------------------------------------------------------------------------------------

function unilib.bushes._grow_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each bush
    --      sapling
    -- Converts a sapling into a bush

    -- Retrieve data for this sapling
    local data_table = unilib.global.sapling_table[full_name]
    if data_table == nil then
        return false
    end

    -- Some bushes provide special handling for growing the sapling
    if data_table.grow_func ~= nil then
        return data_table.grow_func(pos, full_name)
    end

    -- (Compulsory)
    local part_name = data_table.part_name
    -- (Optional)
    local offset_list = data_table.offset_list or {1, 1, 1}
    local schem_list = data_table.schem_list

    unilib.utils.log(
        "action",
        "The " .. part_name .. " bush sapling grows into a bush at " .. core.pos_to_string(pos)
    )

    -- From default: bushes do not need "from sapling" schematic variants because only the stem node
    --      is force-placed in the schematic
    if schem_list == nil then

        -- Use a schematic whose name is in a standard format
        core.place_schematic(
            {x = pos.x - offset_list[1], y = pos.y - offset_list[2], z = pos.z - offset_list[3]},
            unilib.core.path_mod .. "/mts/unilib_bush_" .. part_name .. ".mts",
            "0",
            nil,
            false
        )

    else

        -- Use one of the specified schematics at random
        local mini_list = schem_list[math.random(#schem_list)]

        core.place_schematic(
            {x = pos.x - mini_list[2], y = pos.y - mini_list[3], z = pos.z - mini_list[4]},
            unilib.core.path_mod .. "/mts/" .. mini_list[1] .. ".mts",
            "0",
            nil,
            false
        )

    end

end
