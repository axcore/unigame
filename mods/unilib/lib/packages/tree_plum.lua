---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/plumtree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_plum = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plumtree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_plum.init()

    return {
        description = "Plum tree",
        notes = "Produces plums",
        depends = "fruit_plum",
    }

end

function unilib.pkg.tree_plum.exec()

    local burnlevel = 3
    local sci_name = "Prunus domestica"

    unilib.register_tree({
        -- Original to unilib
        part_name = "plum",
        description = S("Plum Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From plumtree:trunk. Creates unilib:tree_plum_trunk
        part_name = "plum",
        orig_name = "plumtree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Plum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From plumtree:wood. Creates unilib:tree_plum_wood
        part_name = "plum",
        orig_name = "plumtree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Plum Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From plumtree:leaves. Creates unilib:tree_plum_leaves
        part_name = "plum",
        orig_name = "plumtree:leaves",

        replace_mode = mode,
        description = S("Plum Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From plumtree:leaves
        trunk_type = "plum",
        trunks = {"unilib:tree_plum_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_plum_leaves"},
        others = {"unilib:fruit_plum"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From plumtree:sapling. Creates unilib:tree_plum_sapling
        part_name = "plum",
        orig_name = "plumtree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Plum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code's .offset_list, when imported to unilib, causes the tree's base node
        --      to grow beneath the surface
--      offset_list = {4, 1, 4},
        offset_list = {4, 0, 4},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From plumtree:fence. Creates unilib:tree_plum_wood_fence
        part_name = "plum",
        orig_name = "plumtree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_plum_wood.png",
        burnlevel = burnlevel,
        description = S("Plum Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From plumtree:fence_rail. Creates unilib:tree_plum_wood_fence_rail
        part_name = "plum",
        orig_name = "plumtree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_plum_wood.png",
        burnlevel = burnlevel,
        description = S("Plum Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From plumtree:gate_closed, etc. Creates unilib:gate_plum_closed, etc
        part_name = "plum",
        orig_name = {"plumtree:gate_closed", "plumtree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Plum Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_plum", {
        -- From plumtree/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_plum.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            offset = 0.00005,
            scale = 0.00004,
            spread = {x = 250, y = 250, z = 250},
            seed = 23278,
            octaves = 3,
            persist = 0.66
        },
        rotation = "random",
        sidelen = 16,
    })

end
