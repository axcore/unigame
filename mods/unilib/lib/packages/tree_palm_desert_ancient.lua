---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_desert_ancient = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_desert_ancient.init()

    return {
        description = "Ancient desert palm tree",
    }

end

function unilib.pkg.tree_palm_desert_ancient.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_desert_ancient",
        description = S("Ancient Desert Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_palm_desert_01_trunk. Creates unilib:tree_palm_desert_ancient_trunk
        part_name = "palm_desert_ancient",
        orig_name = "lib_ecology:tree_palm_desert_01_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Desert Palm Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_palm_desert_01_wood. Creates unilib:tree_palm_desert_ancient_wood
        part_name = "palm_desert_ancient",
        orig_name = "lib_ecology:tree_palm_desert_01_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Desert Palm Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_palm_desert_01_leaves. Creates
        --      unilib:tree_palm_desert_ancient_leaves
        part_name = "palm_desert_ancient",
        orig_name = "lib_ecology:tree_palm_desert_01_leaves",

        replace_mode = mode,
        description = S("Ancient Desert Palm Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("palm_desert_ancient")

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_palm_desert_01_sapling. Creates
        --      unilib:tree_palm_desert_ancient_sapling
        part_name = "palm_desert_ancient",
        orig_name = "lib_ecology:tree_palm_desert_01_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ancient Desert Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 1, y = 10, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        schem_list = {
            {"unilib_glem_tree_palm_desert_ancient_1", 1, 1, 1},
            {"unilib_glem_tree_palm_desert_ancient_2", 0, 1, 0},
        },
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "palm_desert_ancient",

        replace_mode = mode,
        fence_description = S("Ancient Desert Palm Tree Wood Fence"),
        gate_description = S("Ancient Desert Palm Tree Wood Fence Rail"),
        rail_description = S("Ancient Desert Palm Tree Wood Fence Gate"),
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("glem_tree_palm_desert_ancient_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_palm_desert_ancient_" .. i ..
                    ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
