---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_misc.lua
--      Miscellaneous utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_random_seed()

    -- Generates a random seed in the range -32768 to 32767 (an arbitrary range of integers, that is
    --      nevertheless used consistently by unilib code)
    -- In most cases, this function should not be called; instead, use unilib's seed offset to
    --      produce pseudo-random seeds that are consistent across sessions (see the "ore_gaia"
    --      package for a working example)
    --
    -- Return values
    --      The random value

    return math.random(-32768, 32767)

end

function unilib.utils._prune_fishing_list(list)

    -- Three global variables provide lists of items that can be caught by a fishing rod
    -- This function is passed one of those lists
    -- Returns a modified list, with any item which doesn't exist (or which is associated with a
    --      biome or fishing rod that doesn't exist) removed
    --
    -- Args:
    --      list (list): The list to check
    --
    -- Return values:
    --      The modified list

    local mod_list = {}
    for _, mini_table in ipairs(list) do

        if (
            mini_table.full_name ~= nil and
            (
                core.registered_nodes[mini_table.full_name] ~= nil or
                core.registered_craftitems[mini_table.full_name] ~= nil or
                core.registered_tools[mini_table.full_name] ~= nil
            )
        ) and (
            mini_table.biome_name == nil or
            unilib.global.biome_info_table[mini_table.biome_name] ~= nil
        ) and (
            mini_table.rod_name == nil or core.registered_nodes[mini_table.rod_name] ~= nil
        ) then
            table.insert(mod_list, mini_table)
        end

    end

    return mod_list

end

function unilib.utils._set_auto_rotate(full_name, flag)

    -- Original to unilib
    -- Call for any block to which auto-rotation should be applied, or not, depending on some
    --      setting (typically brick nodes)
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_obsidian_brick"
    --      flag (bool): True to auto-rotate the block in a standard direction, false otherwise

    if not flag then

        unilib.override_item(full_name, {
            paramtype2 = "facedir",

            on_place = core.rotate_node,
        })

    else

        unilib.override_item(full_name, {
            paramtype2 = "facedir",
            place_param2 = 0,
        })

    end

end
