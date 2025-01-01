---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_beech_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_beech_mature.init()

    return {
        description = "Mature Beech tree",
    }

end

function unilib.pkg.tree_beech_mature.exec()

    local burnlevel = 3
    local sci_name = "Fagus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "beech_mature",
        description = S("Mature Beech Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_beech_trunk. Creates unilib:tree_beech_mature_trunk
        part_name = "beech_mature",
        orig_name = "lib_ecology:tree_beech_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Beech Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_beech_wood. Creates unilib:tree_beech_mature_wood
        part_name = "beech_mature",
        orig_name = "lib_ecology:tree_beech_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Beech Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_beech_leaves. Creates unilib:tree_beech_mature_leaves
        part_name = "beech_mature",
        orig_name = "lib_ecology:tree_beech_leaves",

        replace_mode = mode,
        description = S("Mature Beech Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("beech_mature")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_beech_sapling. Creates unilib:tree_beech_mature_sapling
        part_name = "beech_mature",
        orig_name = "lib_ecology:tree_beech_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Beech Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 9, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 1, 4},
        schem_list = {
            {"unilib_glem_tree_beech_mature_1"},
            {"unilib_glem_tree_beech_mature_2"},
            {"unilib_glem_tree_beech_mature_3"},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "beech_mature",

        replace_mode = mode,
        fence_description = S("Mature Beech Wood Fence"),
        gate_description = S("Mature Beech Wood Fence Rail"),
        rail_description = S("Mature Beech Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("glem_tree_beech_mature_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_beech_mature_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
