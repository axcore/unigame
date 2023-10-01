---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_dry.init()

    return {
        description = "Dry tree",
    }

end

function unilib.pkg.tree_dry.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "dry",
        description = S("Dry Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From GLEMr4, lib_ecology:tree_dry_trunk. Creates unilib:tree_dry_trunk
        part_name = "dry",
        orig_name = "lib_ecology:tree_dry_trunk",

        replace_mode = mode,
        common_group = 2,
        description = S("Dry Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From GLEMr4, lib_ecology:tree_dry_wood. Creates unilib:tree_dry_wood
        part_name = "dry",
        orig_name = "lib_ecology:tree_dry_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Dry Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From GLEMr4, lib_ecology:tree_dry_leaves. Creates unilib:tree_dry_leaves
        part_name = "dry",
        orig_name = "lib_ecology:tree_dry_leaves",

        replace_mode = mode,
        description = S("Dry Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("dry")

    unilib.register_tree_sapling({
        -- From GLEMr4, lib_ecology:tree_dry_sapling. Creates unilib:tree_dry_sapling
        part_name = "dry",
        orig_name = "lib_ecology:tree_dry_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Dry Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 6, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {2, 1, 2},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "dry",

        replace_mode = mode,
        fence_description = S("Dry Tree Wood Fence"),
        gate_description = S("Dry Tree Wood Fence Rail"),
        rail_description = S("Dry Tree Wood Fence Gate"),
    })

end
