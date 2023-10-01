---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_birch_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_birch_small.init()

    return {
        description = "Small birch tree",
    }

end

function unilib.pkg.tree_birch_small.exec()

    -- (no burnlevel)
    local sci_name = "Betula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "birch_small",
        description = S("Small Birch Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_birch_02_trunk. Creates unilib:tree_birch_small_trunk
        part_name = "birch_small",
        orig_name = "lib_ecology:tree_birch_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Small Birch Tree Trunk"),
        sci_name = sci_name,
    })
    unilib.override_item("unilib:tree_birch_small_trunk", {
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_birch_02_wood. Creates unilib:tree_birch_small_wood
        part_name = "birch_small",
        orig_name = "lib_ecology:tree_birch_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Small Birch Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_birch_02_leaves. Creates unilib:tree_birch_small_leaves
        part_name = "birch_small",
        orig_name = "lib_ecology:tree_birch_02_leaves",

        replace_mode = mode,
        description = S("Small Birch Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("birch_small")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_birch_02_sapling. Creates unilib:tree_birch_small_sapling
        part_name = "birch_small",
        orig_name = "lib_ecology:tree_birch_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Small Birch Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 4, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_birch_small_1", 2, 1, 2},
            {"unilib_glem_tree_birch_small_2", 2, 1, 2},
            {"unilib_glem_tree_birch_small_3", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "birch_small",

        replace_mode = mode,
        fence_description = S("Small Birch Wood Fence"),
        gate_description = S("Small Birch Wood Fence Rail"),
        rail_description = S("Small Birch Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration("glem_tree_birch_small_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_birch_small_" .. i .. ".mts",

            fill_ratio = 0.002,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
