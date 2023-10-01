---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_caribbean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_caribbean.init()

    return {
        description = "Caribbean palm tree",
        notes = "Produces coconuts",
        depends = "fruit_coconut",
    }

end

function unilib.pkg.tree_palm_caribbean.exec()

    -- (no burnlevel)
    local sci_name = "Roystonea oleracea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_caribbean",
        description = S("Caribbean Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_palm_coconut_trunk. Creates unilib:tree_palm_caribbean_trunk
        part_name = "palm_caribbean",
        orig_name = "lib_ecology:tree_palm_coconut_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Caribbean Palm Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_palm_coconut_wood. Creates unilib:tree_palm_caribbean_wood
        part_name = "palm_caribbean",
        orig_name = "lib_ecology:tree_palm_coconut_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Caribbean Palm Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_palm_coconut_leaves. Creates unilib:tree_palm_caribbean_leaves
        part_name = "palm_caribbean",
        orig_name = "lib_ecology:tree_palm_coconut_leaves",

        replace_mode = mode,
        description = S("Caribbean Palm Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From lib_ecology:tree_palm_coconut_leaves
        trunks = {"unilib:tree_palm_caribbean_trunk"},
        leaves = {"unilib:tree_palm_caribbean_leaves", "unilib:fruit_coconut"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_palm_coconut_sapling. Creates unilib:tree_palm_caribbean_sapling
        part_name = "palm_caribbean",
        orig_name = "lib_ecology:tree_palm_coconut_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Caribbean Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 11, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_palm_caribbean_1", 2, 1, 3},
            {"unilib_glem_tree_palm_caribbean_2", 2, 1, 1},
            {"unilib_glem_tree_palm_caribbean_3", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "palm_caribbean",

        replace_mode = mode,
        fence_description = S("Caribbean Palm Tree Wood Fence"),
        gate_description = S("Caribbean Palm Tree Wood Fence Rail"),
        rail_description = S("Caribbean Palm Tree Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration("glem_tree_palm_caribbean_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_palm_caribbean_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
