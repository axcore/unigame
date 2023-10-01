---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_lavender = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_lavender.init()

    return {
        description = "Lavender tree",
        notes = "Produces lavender fruit",
        depends = "fruit_lavender",
    }

end

function unilib.pkg.tree_lavender.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "lavender",
        description = S("Lavender Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_lavender_trunk. Creates unilib:tree_lavender_trunk
        part_name = "lavender",
        orig_name = "lib_ecology:tree_lavender_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Lavender Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_lavender_wood. Creates unilib:tree_lavender_wood
        part_name = "lavender",
        orig_name = "lib_ecology:tree_lavender_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Lavender Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_lavender_leaves. Creates unilib:tree_lavender_leaves
        part_name = "lavender",
        orig_name = "lib_ecology:tree_lavender_leaves",

        replace_mode = mode,
        description = S("Lavender Tree Leaves"),
    })
    unilib.register_leafdecay({
        -- From lib_ecology:tree_lavender_leaves
        trunks = {"unilib:tree_lavender_trunk"},
        leaves = {"unilib:tree_lavender_leaves", "unilib:fruit_lavender"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_lavender_sapling. Creates unilib:tree_lavender_sapling
        part_name = "lavender",
        orig_name = "lib_ecology:tree_lavender_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Lavender Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 8, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_lavender_1", 2, 1, 2},
        },
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "lavender",

        replace_mode = mode,
        fence_description = S("Lavender Tree Wood Fence"),
        gate_description = S("Lavender Tree Wood Fence Rail"),
        rail_description = S("Lavender Tree Wood Fence Gate"),
    })

    unilib.register_decoration("glem_tree_lavender_1", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_glem_tree_lavender_1.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
