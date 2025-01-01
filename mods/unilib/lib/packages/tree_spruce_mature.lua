---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_spruce_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_spruce_mature.init()

    return {
        description = "Mature spruce tree",
        notes = "Produces mature spruce cones",
        depends = "ingredient_cone_spruce_mature",
    }

end

function unilib.pkg.tree_spruce_mature.exec()

    local burnlevel = 2
    local sci_name = "Picea abies"

    unilib.register_tree({
        -- Original to unilib
        part_name = "spruce_mature",
        description = S("Mature Spruce Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_spruce_trunk. Creates unilib:tree_spruce_mature_trunk
        part_name = "spruce_mature",
        orig_name = "lib_ecology:tree_spruce_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Spruce Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_spruce_wood. Creates unilib:tree_spruce_mature_wood
        part_name = "spruce_mature",
        orig_name = "lib_ecology:tree_spruce_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Spruce Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_spruce_leaves. Creates unilib:tree_spruce_mature_leaves
        part_name = "spruce_mature",
        orig_name = "lib_ecology:tree_spruce_leaves",

        replace_mode = mode,
        description = S("Mature Spruce Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From GLEMr4, lib_ecology:tree_spruce_leaves
        trunk_type = "spruce_mature",
        trunks = {"unilib:tree_spruce_mature_trunk"},
        leaves = {"unilib:tree_spruce_mature_leaves"},
        others = {"unilib:ingredient_cone_spruce_mature"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_spruce_sapling. Creates unilib:tree_spruce_mature_sapling
        part_name = "spruce_mature",
        orig_name = "lib_ecology:tree_spruce_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Spruce Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 35, z = 9},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_glem_tree_spruce_mature_1", 8, 1, 8},
            {"unilib_glem_tree_spruce_mature_2", 7, 1, 8},
            {"unilib_glem_tree_spruce_mature_3", 7, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "spruce_mature",

        replace_mode = mode,
        fence_description = S("Mature Spruce Wood Fence"),
        gate_description = S("Mature Spruce Wood Fence Rail"),
        rail_description = S("Mature Spruce Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("glem_tree_spruce_mature_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_spruce_mature_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
