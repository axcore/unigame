---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cypress = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cypress.init()

    return {
        description = "Cypress tree",
    }

end

function unilib.pkg.tree_cypress.exec()

    -- (no burnlevel)
    local sci_name = "Cupressus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cypress",
        description = S("Cypress Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_cypress_trunk. Creates unilib:tree_cypress_trunk
        part_name = "cypress",
        orig_name = "lib_ecology:tree_cypress_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Cypress Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_cypress_wood. Creates unilib:tree_cypress_wood
        part_name = "cypress",
        orig_name = "lib_ecology:tree_cypress_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Cypress Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_cypress_leaves. Creates unilib:tree_cypress_leaves
        part_name = "cypress",
        orig_name = "lib_ecology:tree_cypress_leaves",

        replace_mode = mode,
        description = S("Cypress Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("cypress")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_cypress_sapling. Creates unilib:tree_cypress_sapling
        part_name = "cypress",
        orig_name = "lib_ecology:tree_cypress_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Cypress Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 18, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_cypress_1", 2, 1, 2},
            {"unilib_glem_tree_cypress_2", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "cypress",

        replace_mode = mode,
        fence_description = S("Cypress Wood Fence"),
        gate_description = S("Cypress Wood Fence Rail"),
        rail_description = S("Cypress Wood Fence Gate"),
    })

    for i = 1, 2 do

        unilib.register_decoration("glem_tree_cypress_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_cypress_" .. i .. ".mts",

            fill_ratio = 0.005,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
