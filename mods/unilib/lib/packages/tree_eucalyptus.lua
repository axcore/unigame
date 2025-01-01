---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_eucalyptus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_eucalyptus.init()

    return {
        description = "Eucalyptus tree",
    }

end

function unilib.pkg.tree_eucalyptus.exec()

    local burnlevel = 3
    local sci_name = "Eucalyptus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "eucalyptus",
        description = S("Eucalyptus Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_eucalyptus_trunk. Creates unilib:tree_eucalyptus_trunk
        part_name = "eucalyptus",
        orig_name = "lib_ecology:tree_eucalyptus_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Eucalyptus Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_eucalyptus_wood. Creates unilib:tree_eucalyptus_wood
        part_name = "eucalyptus",
        orig_name = "lib_ecology:tree_eucalyptus_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Eucalyptus Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_eucalyptus_leaves. Creates unilib:tree_eucalyptus_leaves
        part_name = "eucalyptus",
        orig_name = "lib_ecology:tree_eucalyptus_leaves",

        replace_mode = mode,
        description = S("Eucalyptus Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("eucalyptus")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_eucalyptus_sapling. Creates unilib:tree_eucalyptus_sapling
        part_name = "eucalyptus",
        orig_name = "lib_ecology:tree_eucalyptus_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Eucalyptus Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 19, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            -- N.B. {3, 1, 2} instead of {2, 1, 2} because of the lopsided schematic
            {"unilib_glem_tree_eucalyptus_1", 3, 1, 2},
            {"unilib_glem_tree_eucalyptus_large_1", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "eucalyptus",

        replace_mode = mode,
        fence_description = S("Eucalyptus Wood Fence"),
        gate_description = S("Eucalyptus Wood Fence Rail"),
        rail_description = S("Eucalyptus Wood Fence Gate"),
    })

    for _, part_name in pairs({"eucalyptus_1", "eucalyptus_large_1"}) do

        unilib.register_decoration_generic("glem_tree_" .. part_name, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_" .. part_name .. ".mts",

            fill_ratio = 0.002,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
