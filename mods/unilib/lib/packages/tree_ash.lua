---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_ash = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_ash.init()

    return {
        description = "Ash tree",
    }

end

function unilib.pkg.tree_ash.exec()

    local burnlevel = 4
    local sci_name = "Fraxinus excelsior"

    unilib.register_tree({
        -- Original to unilib
        part_name = "ash",
        description = S("Ash Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_ash_trunk. Creates unilib:tree_ash_trunk
        part_name = "ash",
        orig_name = "lib_ecology:tree_ash_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Ash Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_ash_wood. Creates unilib:tree_ash_wood
        part_name = "ash",
        orig_name = "lib_ecology:tree_ash_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Ash Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_ash_leaves. Creates unilib:tree_ash_leaves
        part_name = "ash",
        orig_name = "lib_ecology:tree_ash_leaves",

        replace_mode = mode,
        description = S("Ash Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("ash")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_ash_sapling. Creates unilib:tree_ash_sapling
        part_name = "ash",
        orig_name = "lib_ecology:tree_ash_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ash Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 17, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_glem_tree_ash_1", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "ash",

        replace_mode = mode,
        fence_description = S("Ash Wood Fence"),
        gate_description = S("Ash Wood Fence Rail"),
        rail_description = S("Ash Wood Fence Gate"),
    })

    unilib.register_decoration_generic("glem_tree_ash_1", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_ash_1.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
