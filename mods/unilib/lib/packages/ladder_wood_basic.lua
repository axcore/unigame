---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_wood_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_wood_basic.init()

    return {
        description = "Wooden ladder set",
        notes = "This package creates ladders from a limited range of super trees. For the" ..
                " ladder crafted with apple tree wood, see the \"ladder_wood_ordinary\" package",
    }

end

function unilib.pkg.ladder_wood_basic.post()

    local ladder_table = {}

    -- Currently, only a small selection of wooden ladder variants are available
    local update_list = {
        {
            part_name = "acacia",
            orig_name = "mtg_plus:ladder_acacia_wood",
            burnlevel = 4,
        },
        -- N.B. For the ladder crafted with apple tree wood, see the "ladder_wood_ordinary" package
--      {
--          part_name = "apple",
--          orig_name = "wood",
--          burnlevel = 3,
--      },
        {
            part_name = "aspen",
            orig_name = "mtg_plus:ladder_aspen_wood",
            burnlevel = 1,
        },
        {
            part_name = "jungle",
            orig_name = "mtg_plus:ladder_junglewood",
            burnlevel = 5,
        },
        {
            part_name = "pine",
            orig_name = "mtg_plus:ladder_pine_wood",
            burnlevel = 2,
        },
    }

    for _, mini_table in pairs(update_list) do

        if unilib.super_tree_table[mini_table.part_name] ~= nil then
            ladder_table[mini_table.part_name] = mini_table
        end

    end

    for _, mini_table in pairs(ladder_table) do

        local data_table = unilib.tree_table[mini_table.part_name]
        local ingredient = "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            unilib.register_ladder({
                part_name = "wood_" .. mini_table.part_name,
                orig_name = mini_table.orig_name,
                ingredient = "group:stick",

                replace_mode = mode,
                centre_ingredient = ingredient,
                description = unilib.brackets(S("Wooden Ladder"), data_table.description),
                group_table = {choppy = 3, flammable = 1},
                multiple = 9,
                sound_name = "wood",
            })
            unilib.register_craft({
                type = "fuel",
                recipe = "unilib:ladder_wood_" .. mini_table.part_name,
                burntime = unilib.tree_burn_table.ladder[mini_table.burnlevel]
            })

        end

    end

end

