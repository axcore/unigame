---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fir_douglas_coast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fir_douglas_coast.init()

    return {
        description = "Coast douglas fir tree",
    }

end

function unilib.pkg.tree_fir_douglas_coast.exec()

    local burnlevel = 3
    local sci_name = "Pseudotsuga menziesii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fir_douglas_coast",
        description = S("Coast Douglas Fir Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_fir_coast_trunk. Creates
        --      unilib:tree_fir_douglas_coast_trunk
        part_name = "fir_douglas_coast",
        orig_name = "lib_ecology:tree_fir_coast_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Coast Douglas Fir Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_fir_coast_wood. Creates unilib:tree_fir_douglas_coast_wood
        part_name = "fir_douglas_coast",
        orig_name = "lib_ecology:tree_fir_coast_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Coast Douglas Fir Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_fir_coast_leaves. Creates
        --      unilib:tree_fir_douglas_coast_leaves
        part_name = "fir_douglas_coast",
        orig_name = "lib_ecology:tree_fir_coast_leaves",

        replace_mode = mode,
        description = S("Coast Douglas Fir Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("fir_douglas_coast")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_fir_coast_sapling. Creates
        --      unilib:tree_fir_douglas_coast_sapling
        part_name = "fir_douglas_coast",
        orig_name = "lib_ecology:tree_fir_coast_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Coast Douglas Fir Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 26, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            -- N.B. For this package, ignoring unilib_glem_tree_fir_douglas_coast_11, etc
            {"unilib_glem_tree_fir_douglas_coast_1", 2, 1, 2},
            {"unilib_glem_tree_fir_douglas_coast_2", 1, 1, 1},
            {"unilib_glem_tree_fir_douglas_coast_3", 1, 1, 1},
            {"unilib_glem_tree_fir_douglas_coast_4", 3, 1, 3},
            {"unilib_glem_tree_fir_douglas_coast_5", 3, 1, 3},
            {"unilib_glem_tree_fir_douglas_coast_6", 3, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "fir_douglas_coast",

        replace_mode = mode,
        fence_description = S("Coast Douglas Fir Wood Fence"),
        gate_description = S("Coast Douglas Fir Wood Fence Rail"),
        rail_description = S("Coast Douglas Fir Wood Fence Gate"),
    })

    for i = 1, 6 do

        unilib.register_decoration_generic("glem_tree_fir_douglas_coast_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod ..
                    "/mts/unilib_glem_tree_fir_douglas_coast_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
