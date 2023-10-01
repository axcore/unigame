---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_teak = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_teak.init()

    return {
        description = "Teak tree",
    }

end

function unilib.pkg.tree_teak.exec()

    -- (no burnlevel)
    local sci_name = "Tectona grandis"

    unilib.register_tree({
        -- Original to unilib
        part_name = "teak",
        description = S("Teak Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_teak_trunk. Creates unilib:tree_teak_trunk
        part_name = "teak",
        orig_name = "lib_ecology:tree_teak_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Teak Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_teak_wood. Creates unilib:tree_teak_wood
        part_name = "teak",
        orig_name = "lib_ecology:tree_teak_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Teak Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_teak_leaves. Creates unilib:tree_teak_leaves
        part_name = "teak",
        orig_name = "lib_ecology:tree_teak_leaves",

        replace_mode = mode,
        description = S("Teak Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("teak")

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_teak_sapling. Creates unilib:tree_teak_sapling
        part_name = "teak",
        orig_name = "lib_ecology:tree_teak_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Teak Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 14, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_teak_1", 3, 1, 3},
            {"unilib_glem_tree_teak_2", 3, 1, 3},
            {"unilib_glem_tree_teak_3", 3, 1, 3},
            {"unilib_glem_tree_teak_4", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "teak",

        replace_mode = mode,
        fence_description = S("Teak Wood Fence"),
        gate_description = S("Teak Wood Fence Rail"),
        rail_description = S("Teak Wood Fence Gate"),
    })

    for i = 1, 4 do

        unilib.register_decoration("glem_tree_teak_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_teak_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
