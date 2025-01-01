---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_jungle.init()

    return {
        description = "Jungle palm tree",
        notes = "Other GLEMr4 trees marked as jungle palms, are actually not",
    }

end

function unilib.pkg.tree_palm_jungle.exec()

    local burnlevel = 2
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_jungle",
        description = S("Jungle Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_02_trunk. Creates unilib:tree_palm_jungle_trunk
        part_name = "palm_jungle",
        orig_name = "lib_ecology:tree_jungle_palm_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Jungle Palm Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_02_wood. Creates unilib:tree_palm_jungle_wood
        part_name = "palm_jungle",
        orig_name = "lib_ecology:tree_jungle_palm_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Jungle Palm Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_02_leaves. Creates
        --      unilib:tree_palm_jungle_leaves
        part_name = "palm_jungle",
        orig_name = "lib_ecology:tree_jungle_palm_02_leaves",

        replace_mode = mode,
        description = S("Jungle Palm Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("palm_jungle")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_jungle_palm_02_sapling. Creates
        --      unilib:tree_palm_jungle_sapling
        part_name = "palm_jungle",
        orig_name = "lib_ecology:tree_jungle_palm_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Jungle Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 27, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_glem_tree_palm_jungle_1", 3, 1, 3},
            {"unilib_glem_tree_palm_jungle_2", 6, 1, 6},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "palm_jungle",

        replace_mode = mode,
        fence_description = S("Jungle Palm Tree Wood Fence"),
        gate_description = S("Jungle Palm Tree Wood Fence Rail"),
        rail_description = S("Jungle Palm Tree Wood Fence Gate"),
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("glem_tree_palm_jungle_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_palm_jungle_" .. i .. ".mts",

            fill_ratio = 0.01,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
