---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_deciduous_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_deciduous_mature.init()

    return {
        description = "Mature deciduous tree",
    }

end

function unilib.pkg.tree_deciduous_mature.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "deciduous_mature",
        description = S("Mature Deciduous Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_generic_trunk_tree_03. Creates
        --      unilib:tree_deciduous_mature_trunk
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_generic_trunk_tree_03",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Deciduous Tree Trunk"),
    })
    unilib.override_item("unilib:tree_deciduous_mature_trunk", {
        tiles = {
            -- N.B. "unilib_tree_apple_trunk_top.png" in original code
            "unilib_tree_deciduous_mature_trunk_top.png",
            "unilib_tree_deciduous_mature_trunk_top.png",
            "unilib_tree_deciduous_mature_trunk.png"
        },
    })

    unilib.register_tree_wood({
        -- Original to unilib. Creates unilib:tree_deciduous_mature_wood
        part_name = "deciduous_mature",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Deciduous Tree Wood Planks"),
    })

    -- (Depending on the schematic used, the trees has one of several types of leaves)
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_green. Creates
        --      unilib:tree_deciduous_mature_leaves
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_leaves_green",

        replace_mode = mode,
        description = S("Mature Deciduous Tree Leaves"),
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_red. Creates unilib:tree_deciduous_mature_leaves_red
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_leaves_red",

        replace_mode = mode,
        description = S("Mature Deciduous Tree Leaves"),
        variant_name = "red",
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_yellow. Creates
        --      unilib:tree_deciduous_mature_leaves_yellow
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_leaves_yellow",

        replace_mode = mode,
        description = S("Mature Deciduous Tree Leaves"),
        variant_name = "yellow",
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_green_2. Creates
        --      unilib:tree_deciduous_mature_leaves_dark
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_leaves_green_2",

        replace_mode = mode,
        base_img = "unilib_tree_deciduous_mature_leaves.png^[colorize:#FF0000:10",
        compacted_img = "unilib_tree_deciduous_mature_leaves_compacted.png^[colorize:#FF0000:10",
        description = S("Mature Deciduous Tree Leaves"),
        variant_name = "dark",
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_green_3. Creates
        --      unilib:tree_deciduous_mature_leaves_light
        part_name = "deciduous_mature",
        orig_name = "lib_ecology:tree_leaves_green_3",

        replace_mode = mode,
        base_img = "unilib_tree_deciduous_mature_leaves.png^[colorize:#FFFF00:30",
        compacted_img = "unilib_tree_deciduous_mature_leaves_compacted.png^[colorize:#FFFF00:30",
        description = S("Mature Deciduous Tree Leaves"),
        variant_name = "light",
    })
    unilib.register_leafdecay({
        -- From GLEMr4, lib_ecology:tree_leaves_green, etc
        trunk_type = "deciduous_mature",
        trunks = {"unilib:tree_deciduous_mature_trunk"},
        leaves = {
            "unilib:tree_deciduous_mature_leaves",
            "unilib:tree_deciduous_mature_leaves_red",
            "unilib:tree_deciduous_mature_leaves_yellow",
            "unilib:tree_deciduous_mature_leaves_dark",
            "unilib:tree_deciduous_mature_leaves_light",
        },
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- Original to unilib. Creates unilib:tree_deciduous_mature_sapling
        part_name = "deciduous_mature",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Deciduous Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 14, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_deciduous_mature_1", 3, 1, 3},
            {"unilib_glem_tree_deciduous_mature_2", 3, 1, 3},
            {"unilib_glem_tree_deciduous_mature_3", 3, 1, 3},
            {"unilib_glem_tree_deciduous_mature_4", 3, 1, 3},
            {"unilib_glem_tree_deciduous_mature_5", 1, 1, 1},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "deciduous_mature",

        replace_mode = mode,
        fence_description = S("Mature Deciduous Tree Wood Fence"),
        gate_description = S("Mature Deciduous Tree Wood Fence Rail"),
        rail_description = S("Mature Deciduous Tree Wood Fence Gate"),
    })

    for i = 1, 5 do

        unilib.register_decoration_generic("glem_tree_deciduous_mature_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                unilib.core.path_mod .. "/mts/unilib_glem_tree_deciduous_mature_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
