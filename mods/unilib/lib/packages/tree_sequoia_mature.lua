---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/sequoia
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_sequoia_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sequoia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_sequoia_mature.init()

    return {
        description = "Mature sequoia tree",
        notes = "Mature sequoia trees are extremely numerous, and tend to crowd out other trees" ..
                " when this package is enabled",
    }

end

function unilib.pkg.tree_sequoia_mature.exec()

    local burnlevel = 3
    local sci_name = "Sequoiadendron giganteum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "sequoia_mature",
        description = S("Mature Sequoia Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From bsequoia:trunk. Creates unilib:tree_sequoia_mature_trunk
        part_name = "sequoia_mature",
        orig_name = "sequoia:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Sequoia Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From sequoia:wood. Creates unilib:tree_sequoia_mature_wood
        part_name = "sequoia_mature",
        orig_name = "sequoia:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Sequoia Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From sequoia:leaves. Creates unilib:tree_sequoia_mature_leaves
        part_name = "sequoia_mature",
        orig_name = "sequoia:leaves",

        replace_mode = mode,
        description = S("Mature Sequoia Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("sequoia_mature")

    unilib.register_tree_sapling({
        -- From sequoia:sapling. Creates unilib:tree_sequoia_mature_sapling
        part_name = "sequoia_mature",
        orig_name = "sequoia:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Sequoia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {7, 4, 7},
        schem_list = {
--          {"unilib_tree_sequoia_mature_small", 3, 4, 4},
            {"unilib_tree_sequoia_mature_small", 3, 0, 4},
--          {"unilib_tree_sequoia_mature_medium", 6, 4, 6},
            {"unilib_tree_sequoia_mature_medium", 6, 2, 6},
            {"unilib_tree_sequoia_mature_large", 7, 4, 7},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From sequoia:fence. Creates unilib:tree_sequoia_mature_wood_fence
        part_name = "sequoia_mature",
        orig_name = "sequoia:fence",

        replace_mode = mode,
        base_img = "unilib_tree_sequoia_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Sequoia Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From sequoia:fence_rail. Creates unilib:tree_sequoia_mature_wood_fence_rail
        part_name = "sequoia_mature",
        orig_name = "sequoia:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_sequoia_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Sequoia Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From sequoia:gate. Creates unilib:gate_sequoia_mature_closed
        part_name = "sequoia_mature",
        orig_name = {"sequoia:gate_closed", "sequoia:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Sequoia Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_sequoia_mature_small", {
        -- From sequoia/init.lua, schematic "sequoia_01.mts"
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_sequoia_mature_small.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.008,
            persist = 0.66,
            scale = 0.0004,
            seed = 67,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = -1,
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration("cool_trees_tree_sequoia_mature_medium", {
        -- From sequoia/init.lua, schematic "sequoia_02.mts"
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_sequoia_mature_medium.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.008,
            persist = 0.66,
            scale = 0.0004,
            seed = 345,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = -1,
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration("cool_trees_tree_sequoia_mature_large", {
        -- From sequoia/init.lua, schematic "sequoia_03.mts"
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_sequoia_mature_large.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0008,
            persist = 0.66,
            scale = 0.00004,
            seed = 23,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = -2,
        rotation = "random",
        sidelen = 16,
    })

end
