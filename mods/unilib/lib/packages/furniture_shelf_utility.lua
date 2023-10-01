---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_shelf_utility = {}

local S = unilib.intllib
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode
local xdecor_add_mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_shelf_utility.init()

    return {
        description = "Utility shelf set",
        notes = "This package creates utility shelves from the full range of super trees",
        optional = "item_sweeper",
        suggested = {
            "item_book_ordinary",               -- group:book
            "vessel_bottle_glass_empty",        -- group:vessel
        },
    }

end

function unilib.pkg.furniture_shelf_utility.post()

    local shelf_table = {}

    -- Super trees
    for tree_type, _ in pairs(unilib.super_tree_table) do

        shelf_table[tree_type] = {
            part_name = tree_type,
            full_orig_name = nil,
            empty_orig_name = nil,
        }

    end

    -- Original mods providing utility shelves. For any that are super trees, overwrite the entry in
    --      shelf_table
    local update_list = {
        {
            part_name = "apple",
            full_orig_name = "xdecor:multishelf",
            empty_orig_name = "moreblocks:empty_shelf",
        },
    }

    for _, mini_table in pairs(update_list) do

        if shelf_table[mini_table.part_name] ~= nil then
            shelf_table[mini_table.part_name] = mini_table
        end

    end

    for _, mini_table in pairs(shelf_table) do

        local data_table = unilib.tree_table[mini_table.part_name]
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            unilib.register_utility_shelf({
                part_name = mini_table.part_name,
                orig_name = mini_table.full_orig_name,

                replace_mode = xdecor_add_mode,
                burnlevel = data_table.burnlevel,
                description = unilib.brackets(S("Utility Shelf"), data_table.description),
            })

            unilib.register_empty_utility_shelf({
                part_name = mini_table.part_name,
                orig_name = mini_table.empty_orig_name,

                replace_mode = moreblocks_add_mode,
                burnlevel = data_table.burnlevel,
                description = unilib.brackets(S("Empty Utility Shelf"), data_table.description),
            })

        end

    end

end
