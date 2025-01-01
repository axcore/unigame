---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_willow_ancient = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_willow_ancient.init()

    return {
        description = "Ancient willow tree",
    }

end

function unilib.pkg.tree_willow_ancient.exec()

    local burnlevel = 2
    local sci_name = "Salix"

    unilib.register_tree({
        -- Original to unilib
        part_name = "willow_ancient",
        description = S("Ancient Willow Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_willow_02_trunk. Creates unilib:tree_willow_ancient_trunk
        part_name = "willow_ancient",
        orig_name = "lib_ecology:tree_willow_02_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Willow Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_willow_02_wood. Creates unilib:tree_willow_ancient_wood
        part_name = "willow_ancient",
        orig_name = "lib_ecology:tree_willow_02_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Willow Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_willow_02_leaves. Creates unilib:tree_willow_ancient_leaves
        part_name = "willow_ancient",
        orig_name = "lib_ecology:tree_willow_02_leaves",

        replace_mode = mode,
        description = S("Ancient Willow Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("willow_ancient")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_willow_02_sapling. Creates
        --      unilib:tree_willow_ancient_sapling
        part_name = "willow_ancient",
        orig_name = "lib_ecology:tree_willow_02_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Willow Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 14, z = 5},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_glem_tree_willow_ancient_1", 5, 1, 5},
            {"unilib_glem_tree_willow_ancient_2", 3, 1, 3},
            {"unilib_glem_tree_willow_ancient_3", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "willow_ancient",

        replace_mode = mode,
        fence_description = S("Ancient Willow Wood Fence"),
        gate_description = S("Ancient Willow Wood Fence Rail"),
        rail_description = S("Ancient Willow Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("glem_tree_willow_ancient_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_willow_ancient_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
