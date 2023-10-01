---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cherry_blossom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cherry_blossom.init()

    return {
        description = "Cherry blossom tree",
    }

end

function unilib.pkg.tree_cherry_blossom.exec()

    -- (no burnlevel)
    local sci_name = "Prunus serrulata"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cherry_blossom",
        description = S("Cherry Blossom Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_cherry_blossom_trunk. Creates
        --      unilib:tree_cherry_blossom_trunk
        part_name = "cherry_blossom",
        orig_name = "lib_ecology:tree_cherry_blossom_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Cherry Blossom Tree Trunk"),
        sci_name = sci_name,
    })
    unilib.override_item("unilib:tree_cherry_blossom_trunk", {
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_cherry_blossom_wood. Creates
        --      unilib:tree_cherry_blossom_wood
        part_name = "cherry_blossom",
        orig_name = "lib_ecology:tree_cherry_blossom_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Cherry Blossom Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_cherry_blossom_leaves. Creates
        --      unilib:tree_cherry_blossom_leaves
        part_name = "cherry_blossom",
        orig_name = "lib_ecology:tree_cherry_blossom_leaves",

        replace_mode = mode,
        description = S("Cherry Blossom Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("cherry_blossom")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_cherry_blossom_sapling. Creates
        --      unilib:tree_cherry_blossom_sapling
        part_name = "cherry_blossom",
        orig_name = "lib_ecology:tree_cherry_blossom_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Cherry Blossom Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 11, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_glem_tree_cherry_blossom_1", 2, 1, 2},
            {"unilib_glem_tree_cherry_blossom_2", 3, 1, 3},
            {"unilib_glem_tree_cherry_blossom_3", 1, 1, 1},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "cherry_blossom",

        replace_mode = mode,
        fence_description = S("Cherry Blossom Tree Wood Fence"),
        gate_description = S("Cherry Blossom Tree Wood Fence Rail"),
        rail_description = S("Cherry Blossom Tree Wood Fence Gate"),
    })

    for i = 1, 3 do

        unilib.register_decoration("glem_tree_cherry_blossom_" .. i, {
            -- Original to unilib
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_glem_tree_cherry_blossom_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
