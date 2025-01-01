---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mangrove_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mangrove_green.init()

    return {
        description = "Green mangrove tree",
    }

end

function unilib.pkg.tree_mangrove_green.exec()

    local burnlevel = 2
    local sci_name = "Conocarpus erectus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mangrove_green",
        description = S("Green Mangrove Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_mangrove_trunk. Creates unilib:tree_mangrove_green_trunk
        part_name = "mangrove_green",
        orig_name = "lib_ecology:tree_mangrove_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Green Mangrove Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_mangrove_wood. Creates unilib:tree_mangrove_green_wood
        part_name = "mangrove_green",
        orig_name = "lib_ecology:tree_mangrove_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Green Mangrove Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_mangrove_leaves. Creates unilib:tree_mangrove_green_leaves
        part_name = "mangrove_green",
        orig_name = "lib_ecology:tree_mangrove_leaves",

        replace_mode = mode,
        description = S("Green Mangrove Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("mangrove_green")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_mangrove_sapling. Creates
        --      unilib:tree_mangrove_green_sapling
        part_name = "mangrove_green",
        orig_name = "lib_ecology:tree_mangrove_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Green Mangrove Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 17, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_mangrove_green_1", 1, 1, 1},
            {"unilib_glem_tree_mangrove_green_2", 2, 1, 2},
            {"unilib_glem_tree_mangrove_green_3", 2, 1, 2},
            {"unilib_glem_tree_mangrove_green_4", 2, 1, 2},
            {"unilib_glem_tree_mangrove_green_5", 1, 1, 1},
            {"unilib_glem_tree_mangrove_green_6", 1, 1, 2},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "mangrove_green",

        replace_mode = mode,
        fence_description = S("Green Mangrove Wood Fence"),
        gate_description = S("Green Mangrove Wood Fence Rail"),
        rail_description = S("Green Mangrove Wood Fence Gate"),
    })

    for i = 1, 6 do

        unilib.register_decoration_generic("glem_tree_mangrave_green_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_glem_tree_mangrove_green_" .. i .. ".mts",

            fill_ratio = 0.35,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
