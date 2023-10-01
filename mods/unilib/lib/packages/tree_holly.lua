---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/hollytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_holly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.hollytree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_holly.init()

    return {
        description = "Holly tree",
    }

end

function unilib.pkg.tree_holly.exec()

    local burnlevel = 3
    local sci_name = "Ilex aquifolium"

    unilib.register_tree({
        -- Original to unilib
        part_name = "holly",
        description = S("Holly Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From hollytree:trunk. Creates unilib:tree_holly_trunk
        part_name = "holly",
        orig_name = "hollytree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Holly Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From hollytree:wood. Creates unilib:tree_holly_wood
        part_name = "holly",
        orig_name = "hollytree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Holly Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From hollytree:leaves. Creates unilib:tree_holly_leaves
        part_name = "holly",
        orig_name = "hollytree:leaves",

        replace_mode = mode,
        description = S("Holly Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("holly")

    unilib.register_tree_sapling({
        -- From hollytree:sapling. Creates unilib:tree_holly_sapling
        part_name = "holly",
        orig_name = "hollytree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Holly Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {4, 0, 4},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From hollytree:fence. Creates unilib:tree_holly_wood_fence
        part_name = "holly",
        orig_name = "hollytree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_holly_wood.png",
        burnlevel = burnlevel,
        description = S("Holly Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From hollytree:fence_rail. Creates unilib:tree_holly_wood_fence_rail
        part_name = "holly",
        orig_name = "hollytree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_holly_wood.png",
        burnlevel = burnlevel,
        description = S("Holly Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From hollytree:gate. Creates unilib:gate_holly_closed
        part_name = "holly",
        orig_name = {"hollytree:gate_closed", "hollytree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Holly Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_holly", {
        -- From hollytree/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_holly.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.00008,
            persist = 0.66,
            scale = 0.00005,
            seed = 789,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
