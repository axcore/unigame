---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_plain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_plain.init()

    return {
        description = "Plain palm tree",
    }

end

function unilib.pkg.tree_palm_plain.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_plain",
        description = S("Plain Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_03_trunk. Creates unilib:tree_palm_plain_trunk
        part_name = "palm_plain",
        orig_name = "lib_ecology:tree_jungle_palm_03_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Plain Palm Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_03_wood. Creates unilib:tree_palm_plain_wood
        part_name = "palm_plain",
        orig_name = "lib_ecology:tree_jungle_palm_03_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Plain Palm Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_03_leaves. Creates
        --      unilib:tree_palm_plain_leaves
        part_name = "palm_plain",
        orig_name = "lib_ecology:tree_jungle_palm_03_leaves",

        replace_mode = mode,
        description = S("Plain Palm Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("palm_plain")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_03_sapling. Creates
        --      unilib:tree_palm_plain_sapling
        part_name = "palm_plain",
        orig_name = "lib_ecology:tree_jungle_palm_03_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Plain Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 27, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_glem_tree_palm_plain_1", 3, 1, 3},
            {"unilib_glem_tree_palm_plain_2", 6, 1, 6},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "palm_plain",

        replace_mode = mode,
        fence_description = S("Plain Palm Tree Wood Fence"),
        gate_description = S("Plain Palm Tree Wood Fence Rail"),
        rail_description = S("Plain Palm Tree Wood Fence Gate"),
    })

    for i = 1, 2 do

        unilib.register_decoration("glem_tree_palm_plain_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_palm_plain_" .. i .. ".mts",

            fill_ratio = 0.01,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
