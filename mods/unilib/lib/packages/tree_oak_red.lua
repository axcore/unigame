---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak_red.init()

    return {
        description = "Red oak tree",
        notes = "Produces acorns",
        depends = "ingredient_acorn",
    }

end

function unilib.pkg.tree_oak_red.exec()

    local burnlevel = 5
    local sci_name = "Quercus rubra"

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak_red",
        description = S("Red Oak Wood"),
    })

    unilib.register_tree_trunk({
        -- Original to unilib. Creates unilib:tree_oak_red_trunk
        part_name = "oak_red",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Red Oak Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- Original to unilib. Creates unilib:tree_oak_red_wood
        part_name = "oak_red",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Red Oak Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_oak_red_leaves. Creates unilib:tree_oak_red_leaves
        part_name = "oak_red",
        orig_name = "lib_ecology:tree_oak_red_leaves",

        replace_mode = mode,
        description = S("Red Oak Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From lib_ecology:tree_oak_red_leaves
        trunk_type = "oak_red",
        trunks = {"unilib:tree_oak_red_trunk"},
        leaves = {"unilib:tree_oak_red_leaves"},
        others = {"unilib:ingredient_acorn"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_oak_red_sapling. Creates unilib:tree_oak_red_sapling
        part_name = "oak_red",
        orig_name = "lib_ecology:tree_oak_red_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Red Oak Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 14, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_oak_red_1", 1, 1, 1},
            {"unilib_glem_tree_oak_red_2", 3, 1, 2},
            {"unilib_glem_tree_oak_red_3", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "oak_red",

        replace_mode = mode,
        fence_description = S("Red Oak Wood Fence"),
        gate_description = S("Red Oak Wood Fence Rail"),
        rail_description = S("Red Oak Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("glem_tree_oak_red_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_oak_red_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
