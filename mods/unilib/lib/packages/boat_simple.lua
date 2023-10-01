---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    boats
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.boat_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.boats.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.boat_simple.init()

    return {
        description = "Simple boat set set",
        notes = "This package creates boats from a limited range of super trees",
    }

end

function unilib.pkg.boat_simple.post()

    local boat_table = {}

    -- Currently, only a small selection of boat variants are available
    for _, tree_type in pairs({"acacia", "apple", "aspen", "jungle", "pine"}) do

        if unilib.super_tree_table[tree_type] ~= nil then

            local orig_name = nil
            if tree_type == "apple" then
                orig_name = "boats:boat"
            end

            boat_table[tree_type] = {
                part_name = tree_type,
                orig_name = orig_name,
            }

        end

    end

    for _, mini_table in pairs(boat_table) do

        local data_table = unilib.tree_table[mini_table.part_name]
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            unilib.register_simple_boat({
                part_name = mini_table.part_name,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
                burnlevel = data_table.burnlevel,
                description = unilib.brackets(S("Simple Boat"), data_table.description),
            })

        end

    end

end
