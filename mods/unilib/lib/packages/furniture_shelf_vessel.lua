---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_shelf_vessel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_shelf_vessel.init()

    return {
        description = "Vessels shelf set",
        notes = "This package creates vessels shelves from the full range of super trees",
        suggested = {
            "vessel_bottle_glass_empty",        -- group:vessel
        },
    }

end

function unilib.pkg.furniture_shelf_vessel.post()

    local shelf_table = {}

    -- Super trees
    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        shelf_table[tree_type] = {
            part_name = tree_type,
            orig_name = nil,
        }

    end

    -- Original mods providing vessels shelves. For any that are super trees, overwrite the entry in
    --      shelf_table
    local default_list = {
        {
            part_name = "apple",
            orig_name = "vessels:shelf",
        },
    }

    for _, mini_table in pairs(default_list) do

        if shelf_table[mini_table.part_name] ~= nil then
            shelf_table[mini_table.part_name] = mini_table
        end

    end

    for _, mini_table in pairs(shelf_table) do

        local data_table = unilib.global.tree_table[mini_table.part_name]
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.global.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            unilib.register_vessels_shelf({
                part_name = mini_table.part_name,
                orig_name = mini_table.orig_name,

                replace_mode = mode,
                burnlevel = data_table.burnlevel,
                description = unilib.utils.brackets(S("Vessels Shelf"), data_table.description),
            })

        end

    end

end
