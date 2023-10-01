---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_beech_southern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_beech_southern.init()

    return {
        description = "Southern beech tree",
    }

end

function unilib.pkg.tree_beech_southern.exec()

    -- (no burnlevel)
    local sci_name = "Nothofagus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "beech_southern",
        description = S("Southern Beech Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr11, lib_ecology:tree_beech_southern_trunk. Creates
        --      unilib:tree_beech_southern_trunk
        part_name = "beech_southern",
        orig_name = "lib_ecology:tree_beech_southern_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Southern Beech Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr11, lib_ecology:tree_beech_southern_wood. Creates
        --      unilib:tree_beech_southern_wood
        part_name = "beech_southern",
        orig_name = "lib_ecology:tree_beech_southern_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Southern Beech Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr11, lib_ecology:tree_beech_southern_leaves. Creates
        --      unilib:tree_beech_southern_leaves
        part_name = "beech_southern",
        orig_name = "lib_ecology:tree_beech_southern_leaves",

        replace_mode = mode,
        description = S("Southern Beech Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("beech_southern")

    unilib.register_tree_sapling({
        -- From GLEMr11, lib_ecology:tree_beech_southern_sapling. Creates
        --      unilib:tree_beech_southern_sapling
        part_name = "beech_southern",
        orig_name = "lib_ecology:tree_beech_southern_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Southern Beech Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 9, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_glem_tree_beech_southern_1", 4, 1, 4},
            {"unilib_glem_tree_beech_southern_2", 4, 1, 4},
            {"unilib_glem_tree_beech_southern_3", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "beech_southern",

        replace_mode = mode,
        fence_description = S("Southern Beech Wood Fence"),
        gate_description = S("Southern Beech Wood Fence Rail"),
        rail_description = S("Southern Beech Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration("glem_tree_beech_southern_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_beech_southern_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
