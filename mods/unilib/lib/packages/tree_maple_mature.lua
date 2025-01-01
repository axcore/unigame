---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_maple_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_maple_mature.init()

    return {
        description = "Mature maple tree",
    }

end

function unilib.pkg.tree_maple_mature.exec()

    local burnlevel = 5
    local sci_name = "Acer"

    unilib.register_tree({
        -- Original to unilib
        part_name = "maple_mature",
        description = S("Mature Maple Wood"),
    })

    unilib.register_tree_trunk({
        -- From lib_ecology:tree_maple_trunk. Creates unilib:tree_maple_mature_trunk
        part_name = "maple_mature",
        orig_name = "lib_ecology:tree_maple_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Maple Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lib_ecology:tree_maple_wood. Creates unilib:tree_maple_mature_wood
        part_name = "maple_mature",
        orig_name = "lib_ecology:tree_maple_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Maple Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From lib_ecology:tree_maple_leaves. Creates unilib:tree_maple_mature_leaves
        part_name = "maple_mature",
        orig_name = "lib_ecology:tree_maple_leaves",

        replace_mode = mode,
        description = S("Mature Maple Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("maple_mature")

    unilib.register_tree_sapling({
        -- From lib_ecology:tree_maple_sapling. Creates unilib:tree_maple_mature_sapling
        part_name = "maple_mature",
        orig_name = "lib_ecology:tree_maple_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mature Maple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 13, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_maple_mature_1", 3, 1, 3},
            {"unilib_glem_tree_maple_mature_large_1", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "maple_mature",

        replace_mode = mode,
        fence_description = S("Mature Maple Wood Fence"),
        gate_description = S("Mature Maple Wood Fence Rail"),
        rail_description = S("Mature Maple Wood Fence Gate"),
    })

    for _, part_name in pairs({"maple_mature_1", "maple_mature_large_1"}) do

        unilib.register_decoration_generic("glem_tree_" .. part_name, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_glem_tree_" .. part_name .. ".mts",

            fill_ratio = 0.002,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
