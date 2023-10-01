---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/lemontree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_lemon_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.lemontree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_lemon_mature.init()

    return {
        description = "Mature lemon tree",
        notes = "Produces mature lemon tree lemons",
        depends = "fruit_lemon_mature",
    }

end

function unilib.pkg.tree_lemon_mature.exec()

    local burnlevel = 3
    local sci_name = "Citrus limon"

    unilib.register_tree({
        -- Original to unilib
        part_name = "lemon_mature",
        description = S("Mature Lemon Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From lemontree:trunk. Creates unilib:tree_lemon_mature_trunk
        part_name = "lemon_mature",
        orig_name = "lemontree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Lemon Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From lemontree:wood. Creates unilib:tree_lemon_mature_wood
        part_name = "lemon_mature",
        orig_name = "lemontree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Lemon Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From lemontree:leaves. Creates unilib:tree_lemon_mature_leaves
        part_name = "lemon_mature",
        orig_name = "lemontree:leaves",

        replace_mode = mode,
        description = S("Mature Lemon Tree Leaves"),
        sapling_rarity = 15,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From lemontree:leaves
        trunks = {"unilib:tree_lemon_mature_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_lemon_mature_leaves", "unilib:fruit_lemon_mature"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From lemontree:sapling. Creates unilib:tree_lemon_mature_sapling
        part_name = "lemon_mature",
        orig_name = "lemontree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Lemon Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From lemontree:fence. Creates unilib:tree_lemon_mature_wood_fence
        part_name = "lemon_mature",
        orig_name = "lemontree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_lemon_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Lemon Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From lemontree:fence_rail. Creates unilib:tree_lemon_mature_wood_fence_rail
        part_name = "lemon_mature",
        orig_name = "lemontree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_lemon_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Lemon Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From lemontree:gate. Creates unilib:gate_lemon_mature_closed
        part_name = "lemon_mature",
        orig_name = {"lemontree:gate_closed", "lemontree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Lemon Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_lemon_mature", {
        -- From lemontree/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_lemon_mature.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.00005,
            seed = 5690,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
