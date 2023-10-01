---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_maple_sugar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_maple_sugar.init()

    return {
        description = "Sugar maple tree",
    }

end

function unilib.pkg.tree_maple_sugar.exec()

    -- (no burnlevel)
    local sci_name = "Acer saccharum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "maple_sugar",
        description = S("Sugar Maple Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_maple_trunk. Creates unilib:tree_maple_sugar_trunk
        part_name = "maple_sugar",
        orig_name = "lib_ecology:tree_maple_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Sugar Maple Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_maple_wood. Creates unilib:tree_maple_sugar_wood
        part_name = "maple_sugar",
        orig_name = "lib_ecology:tree_maple_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Sugar Maple Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_maple_leaves. Creates unilib:tree_maple_sugar_leaves
        part_name = "maple_sugar",
        orig_name = "lib_ecology:tree_maple_leaves",

        replace_mode = mode,
        description = S("Sugar Maple Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("maple_sugar")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_maple_sapling. Creates unilib:tree_maple_sugar_sapling
        part_name = "maple_sugar",
        orig_name = "lib_ecology:tree_maple_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Sugar Maple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 16, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_glem_tree_maple_sugar_1", 3, 1, 3},
            {"unilib_glem_tree_maple_sugar_large_1", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "maple_sugar",

        replace_mode = mode,
        fence_description = S("Sugar Maple Wood Fence"),
        gate_description = S("Sugar Maple Wood Fence Rail"),
        rail_description = S("Sugar Maple Wood Fence Gate"),
    })

    for _, part_name in pairs({"maple_sugar_1", "maple_sugar_large_1"}) do

        unilib.register_decoration("glem_tree_" .. part_name, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_" .. part_name .. ".mts",

            fill_ratio = 0.002,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
