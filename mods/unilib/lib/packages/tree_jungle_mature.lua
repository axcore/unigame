---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jungle_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle_mature.init()

    return {
        description = "Mature jungle tree",
    }

end

function unilib.pkg.tree_jungle_mature.exec()

    local burnlevel = 5
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "jungle_mature",
        description = S("Mature Jungle Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_jungle_02_trunk. Creates unilib:tree_jungle_mature_trunk
        part_name = "jungle_mature",
        orig_name = "lib_ecology:tree_jungle_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Jungle Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_jungle_02_wood. Creates unilib:tree_jungle_mature_wood
        part_name = "jungle_mature",
        orig_name = "lib_ecology:tree_jungle_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Jungle Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_jungle_02_leaves. Creates unilib:tree_jungle_mature_leaves
        part_name = "jungle_mature",
        orig_name = "lib_ecology:tree_jungle_02_leaves",

        replace_mode = mode,
        description = S("Mature Jungle Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("jungle_mature")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_jungle_02_sapling. Creates
        --      unilib:tree_jungle_mature_sapling
        part_name = "jungle_mature",
        orig_name = "lib_ecology:tree_jungle_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Jungle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 23, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_glem_tree_jungle_mature_1", 1, 1, 1},
            {"unilib_glem_tree_jungle_mature_2", 3, 1, 3},
            {"unilib_glem_tree_jungle_mature_3", 3, 1, 3},
            {"unilib_glem_tree_jungle_mature_4", 3, 1, 3},
            {"unilib_glem_tree_jungle_mature_5", 2, 1, 2},
            {"unilib_glem_tree_jungle_mature_6", 2, 1, 2},
            {"unilib_glem_tree_jungle_mature_7", 3, 1, 2},
            {"unilib_glem_tree_jungle_mature_8", 4, 1, 4},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "jungle_mature",

        replace_mode = mode,
        fence_description = S("Mature Jungle Tree Wood Fence"),
        gate_description = S("Mature Jungle Tree Wood Fence Rail"),
        rail_description = S("Mature Jungle Tree Wood Fence Gate"),
    })

    for i = 1, 8 do

        unilib.register_decoration_generic("glem_tree_jungle_mature_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_jungle_mature_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
