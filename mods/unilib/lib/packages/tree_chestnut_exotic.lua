---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_chestnut_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_chestnut_exotic.init()

    return {
        description = "Exotic chestnut tree",
    }

end

function unilib.pkg.tree_chestnut_exotic.exec()

    local burnlevel = 24
    local sci_name = "Castanea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "chestnut_exotic",
        description = S("Exotic Chestnut Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_chestnut_trunk. Creates unilib:tree_chestnut_exotic_trunk
        part_name = "chestnut_exotic",
        orig_name = "lib_ecology:tree_chestnut_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Chestnut Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_chestnut_wood. Creates unilib:tree_chestnut_exotic_wood
        part_name = "chestnut_exotic",
        orig_name = "lib_ecology:tree_chestnut_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Chestnut Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_chestnut_leaves. Creates unilib:tree_chestnut_exotic_leaves
        part_name = "chestnut_exotic",
        orig_name = "lib_ecology:tree_chestnut_leaves",

        replace_mode = mode,
        description = S("Exotic Chestnut Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("chestnut_exotic")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_chestnut_sapling. Creates
        --      unilib:tree_chestnut_exotic_sapling
        part_name = "chestnut_exotic",
        orig_name = "lib_ecology:tree_chestnut_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Chestnut Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 17, z = 3},
        minp_table = {x = -4, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_chestnut_exotic_1", 2, 1, 2},
            {"unilib_glem_tree_chestnut_exotic_2", 4, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "chestnut_exotic",

        replace_mode = mode,
        fence_description = S("Exotic Chestnut Tree Wood Fence"),
        gate_description = S("Exotic Chestnut Tree Wood Fence Rail"),
        rail_description = S("Exotic Chestnut Tree Wood Fence Gate"),
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("glem_tree_chestnut_exotic_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_chestnut_exotic_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
