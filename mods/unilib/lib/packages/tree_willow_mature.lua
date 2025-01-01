---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/willow
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_willow_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.willow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_willow_mature.init()

    return {
        description = "Mature willow tree",
    }

end

function unilib.pkg.tree_willow_mature.exec()

    local burnlevel = 3
    local sci_name = "Salix"

    unilib.register_tree({
        -- Original to unilib
        part_name = "willow_mature",
        description = S("Mature Willow Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From willow:trunk. Creates unilib:tree_willow_mature_trunk
        part_name = "willow_mature",
        orig_name = "willow:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Willow Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From willow:wood. Creates unilib:tree_willow_mature_wood
        part_name = "willow_mature",
        orig_name = "willow:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Willow Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From willow:leaves. Creates unilib:tree_willow_mature_leaves
        part_name = "willow_mature",
        orig_name = "willow:leaves",

        replace_mode = mode,
        description = S("Mature Willow Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("willow_mature")

    unilib.register_tree_sapling({
        -- From willow:sapling. Creates unilib:tree_willow_mature_sapling
        part_name = "willow_mature",
        orig_name = "willow:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Willow Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code is wrong
--      offset_list = {5, 0, 5},
        offset_list = {4, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From willow:fence. Creates unilib:tree_willow_mature_wood_fence
        part_name = "willow_mature",
        orig_name = "willow:fence",

        replace_mode = mode,
        base_img = "unilib_tree_willow_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Willow Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From willow:fence_rail. Creates unilib:tree_willow_mature_wood_fence_rail
        part_name = "willow_mature",
        orig_name = "willow:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_willow_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Willow Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From willow:gate_closed, etc. Creates unilib:gate_willow_mature_closed, etc
        part_name = "willow_mature",
        orig_name = {"willow:gate_closed", "willow:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Willow Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_willow_mature", {
        -- From willow/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_willow_mature.mts",

        flags = "place_center_x, place_center_z, force_placement",
        height = 2,
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.0002,
            seed = 23,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
