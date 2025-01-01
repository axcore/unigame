---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_desert.init()

    return {
        description = "Desert palm tree",
    }

end

function unilib.pkg.tree_palm_desert.exec()

    local burnlevel = 2
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_desert",
        description = S("Desert Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_palm_desert_02_trunk. Creates unilib:tree_palm_desert_trunk
        part_name = "palm_desert",
        orig_name = "lib_ecology:tree_palm_desert_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Palm Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_palm_desert_02_wood. Creates unilib:tree_palm_desert_wood
        part_name = "palm_desert",
        orig_name = "lib_ecology:tree_palm_desert_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Palm Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_palm_desert_02_leaves. Creates unilib:tree_palm_desert_leaves
        part_name = "palm_desert",
        orig_name = "lib_ecology:tree_palm_desert_02_leaves",

        replace_mode = mode,
        description = S("Desert Palm Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("palm_desert")

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_palm_desert_02_sapling. Creates unilib:tree_palm_desert_sapling
        part_name = "palm_desert",
        orig_name = "lib_ecology:tree_palm_desert_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 9, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_palm_desert_1", 2, 1, 2},
            {"unilib_glem_tree_palm_desert_2", 2, 1, 2},
            {"unilib_glem_tree_palm_desert_3", 2, 1, 2},
            {"unilib_glem_tree_palm_desert_4", 2, 1, 2},
            {"unilib_glem_tree_palm_desert_5", 2, 1, 2},
        },
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "palm_desert",

        replace_mode = mode,
        fence_description = S("Desert Palm Tree Wood Fence"),
        gate_description = S("Desert Palm Tree Wood Fence Rail"),
        rail_description = S("Desert Palm Tree Wood Fence Gate"),
    })

    for i = 1, 5 do

        unilib.register_decoration_generic("glem_tree_palm_desert_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_palm_desert_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
