---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_deciduous_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_deciduous_normal.init()

    return {
        description = "Normal deciduous tree",
        notes = "Several GLEMr4 schematics are here combined into one tree package",
    }

end

function unilib.pkg.tree_deciduous_normal.exec()

    local burnlevel = 2
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "deciduous_normal",
        description = S("Normal Deciduous Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_generic_trunk_tree_02. Creates
        --      unilib:tree_deciduous_normal_trunk
        part_name = "deciduous_normal",
        orig_name = "lib_ecology:tree_generic_trunk_tree_02",

        replace_mode = mode,
        common_group = 2,
        description = S("Normal Deciduous Tree Trunk"),
    })
    unilib.override_item("unilib:tree_deciduous_normal_trunk", {
        tiles = {
            -- N.B. "unilib_tree_apple_trunk_top.png" in original code
            "unilib_tree_deciduous_normal_trunk_top.png",
            "unilib_tree_deciduous_normal_trunk_top.png",
            "unilib_tree_deciduous_normal_trunk.png",
        },
    })

    unilib.register_tree_wood({
        -- Original to unilib. Creates unilib:tree_deciduous_normal_wood
        part_name = "deciduous_normal",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Normal Deciduous Tree Wood Planks"),
    })

    -- (Depending on the schematic used, the trees has one of several types of leaves)
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_dk_green. Creates
        --      unilib:tree_deciduous_normal_leaves
        part_name = "deciduous_normal",
        orig_name = "lib_ecology:tree_leaves_dk_green",

        replace_mode = mode,
        description = S("Normal Deciduous Tree Leaves"),
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_dk_green_2. Creates
        --      unilib:tree_deciduous_normal_leaves_dark
        part_name = "deciduous_normal",
        orig_name = "lib_ecology:tree_leaves_dk_green_2",

        replace_mode = mode,
        base_img = "unilib_tree_deciduous_normal_leaves.png^[colorize:#FF0000:10",
        compacted_img = "unilib_tree_deciduous_normal_leaves_compacted.png^[colorize:#FF0000:10",
        description = S("Normal Deciduous Tree Leaves"),
        variant_name = "dark",
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_dk_green_3. Creates
        --      unilib:tree_deciduous_normal_leaves_light
        part_name = "deciduous_normal",
        orig_name = "lib_ecology:tree_leaves_dk_green_3",

        replace_mode = mode,
        base_img = "unilib_tree_deciduous_normal_leaves.png^[colorize:#FFFF00:30",
        compacted_img = "unilib_tree_deciduous_normal_leaves_compacted.png^[colorize:#FFFF00:30",
        description = S("Normal Deciduous Tree Leaves"),
        variant_name = "light",
    })
    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_leaves_green. Creates
        --      unilib:tree_deciduous_normal_leaves_green
        part_name = "deciduous_normal",
        orig_name = "lib_ecology:tree_leaves_green",

        replace_mode = mode,
        description = S("Normal Deciduous Tree Leaves"),
        variant_name = "green",
    })
    unilib.register_leafdecay({
        -- From GLEMr4, lib_ecology:tree_leaves_dk_green, etc
        trunk_type = "deciduous_normal",
        trunks = {"unilib:tree_deciduous_normal_trunk"},
        leaves = {
            "unilib:tree_deciduous_normal_leaves",
            "unilib:tree_deciduous_normal_leaves_dark",
            "unilib:tree_deciduous_normal_leaves_light",
            "unilib:tree_deciduous_normal_leaves_green",
        },
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- Original to unilib. Creates unilib:tree_deciduous_normal_sapling
        part_name = "deciduous_normal",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Normal Deciduous Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 17, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            -- N.B. {3, 1, 2} instead of {2, 1, 2} because of the lopsided schematic
            {"unilib_glem_tree_deciduous_normal_1", 3, 1, 2},
            {"unilib_glem_tree_deciduous_normal_2", 4, 1, 3},
            {"unilib_glem_tree_deciduous_normal_3", 2, 1, 2},
            {"unilib_glem_tree_deciduous_normal_tall_1", 3, 1, 3},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "deciduous_normal",

        replace_mode = mode,
        fence_description = S("Normal Deciduous Tree Wood Fence"),
        gate_description = S("Normal Deciduous Tree Wood Fence Rail"),
        rail_description = S("Normal Deciduous Tree Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("glem_tree_deciduous_normal_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_deciduous_normal_" ..
                    i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

    unilib.register_decoration_generic("glem_tree_deciduous_normal_tall_1", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_deciduous_normal_tall_1.mts",

        fill_ratio = 0.002,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
