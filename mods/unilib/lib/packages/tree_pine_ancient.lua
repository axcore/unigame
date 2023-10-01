---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_ancient = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_ancient.init()

    return {
        description = "Ancient pine tree",
        notes = "Produces ancient pine tree cones",
    }

end

function unilib.pkg.tree_pine_ancient.exec()

    -- (no burnlevel)
    local sci_name = "Pinus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_ancient",
        description = S("Ancient Pine Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_pine_01_trunk. Creates unilib:tree_pine_ancient_trunk
        part_name = "pine_ancient",
        orig_name = "lib_ecology:tree_pine_01_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Pine Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_pine_01_wood. Creates unilib:tree_pine_ancient_wood
        part_name = "pine_ancient",
        orig_name = "lib_ecology:tree_pine_01_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Pine Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_pine_01_leaves. Creates unilib:tree_pine_ancient_leaves
        part_name = "pine_ancient",
        orig_name = "lib_ecology:tree_pine_01_leaves",

        replace_mode = mode,
        description = S("Ancient Pine Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From GLEMr4, lib_ecology:tree_pine_01_leaves
        trunks = {"unilib:tree_pine_ancient_trunk"},
        leaves = {"unilib:tree_pine_ancient_leaves"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_pine_01_sapling. Creates unilib:tree_pine_ancient_sapling
        part_name = "pine_ancient",
        orig_name = "lib_ecology:tree_pine_01_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 26, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_glem_tree_pine_ancient_1", 3, 1, 3},
            {"unilib_glem_tree_pine_ancient_2", 4, 1, 4},
            {"unilib_glem_tree_pine_ancient_3", 2, 1, 2},
            {"unilib_glem_tree_pine_ancient_4", 2, 1, 2},
            {"unilib_glem_tree_pine_ancient_5", 1, 1, 1},
            {"unilib_glem_tree_pine_ancient_6", 1, 1, 1},
            {"unilib_glem_tree_pine_ancient_7", 3, 1, 3},
            {"unilib_glem_tree_pine_ancient_8", 3, 1, 3},
            {"unilib_glem_tree_pine_ancient_9", 3, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "pine_ancient",

        replace_mode = mode,
        fence_description = S("Ancient Pine Wood Fence"),
        gate_description = S("Ancient Pine Wood Fence Rail"),
        rail_description = S("Ancient Pine Wood Fence Gate"),
    })

    for i = 1, 9 do

        unilib.register_decoration("glem_tree_pine_ancient_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_pine_ancient_" .. i .. ".mts",

            fill_ratio = 0.02,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
