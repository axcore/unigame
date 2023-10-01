---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_ginkgo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_ginkgo.init()

    return {
        description = "Ginkgo tree",
    }

end

function unilib.pkg.tree_ginkgo.exec()

    -- (no burnlevel)
    local sci_name = "Ginkgo biloba"

    unilib.register_tree({
        -- Original to unilib
        part_name = "ginkgo",
        description = S("Ginkgo Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_ginkgo_trunk. Creates unilib:tree_ginkgo_trunk
        part_name = "ginkgo",
        orig_name = "lib_ecology:tree_ginkgo_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Ginkgo Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_ginkgo_wood. Creates unilib:tree_ginkgo_wood
        part_name = "ginkgo",
        orig_name = "lib_ecology:tree_ginkgo_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Ginkgo Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_ginkgo_leaves. Creates unilib:tree_ginkgo_leaves
        part_name = "ginkgo",
        orig_name = "lib_ecology:tree_ginkgo_leaves",

        replace_mode = mode,
        description = S("Ginkgo Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("ginkgo")

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_ginkgo_sapling. Creates unilib:tree_ginkgo_sapling
        part_name = "ginkgo",
        orig_name = "lib_ecology:tree_ginkgo_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ginkgo Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 8, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_ginkgo_1", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "ginkgo",

        replace_mode = mode,
        fence_description = S("Ginkgo Wood Fence"),
        gate_description = S("Ginkgo Wood Fence Rail"),
        rail_description = S("Ginkgo Wood Fence Gate"),
    })

    unilib.register_decoration("glem_tree_ginkgo_1", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_glem_tree_ginkgo_1.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
