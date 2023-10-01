---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/clementinetree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_clementine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.clementinetree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_clementine.init()

    return {
        description = "Clementine tree",
        notes = "Produces clementine fruit",
        depends = "fruit_clementine",
    }

end

function unilib.pkg.tree_clementine.exec()

    local burnlevel = 3
    local sci_name = "Citrus clementina"

    unilib.register_tree({
        -- Original to unilib
        part_name = "clementine",
        description = S("Clementine Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From clementinetree:trunk. Creates unilib:tree_clementine_trunk
        part_name = "clementine",
        orig_name = "clementinetree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Clementine Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From clementinetree:wood. Creates unilib:tree_clementine_wood
        part_name = "clementine",
        orig_name = "clementinetree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Clementine Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From clementinetree:leaves. Creates unilib:tree_clementine_leaves
        part_name = "clementine",
        orig_name = "clementinetree:leaves",

        replace_mode = mode,
        description = S("Clementine Tree Leaves"),
        sapling_rarity = 13,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From clementinetree:leaves
        trunks = {"unilib:tree_clementine_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_clementine_leaves", "unilib:fruit_clementine"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From clementinetree:sapling. Creates unilib:tree_clementine_sapling
        part_name = "clementine",
        orig_name = "clementinetree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Clementine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From clementinetree:fence. Creates unilib:tree_clementine_wood_fence
        part_name = "clementine",
        orig_name = "clementinetree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_clementine_wood.png",
        burnlevel = burnlevel,
        description = S("Clementine Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From clementinetree:fence_rail. Creates unilib:tree_clementine_wood_fence_rail
        part_name = "clementine",
        orig_name = "clementinetree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_clementine_wood.png",
        burnlevel = burnlevel,
        description = S("Clementine Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From clementinetree:gate. Creates unilib:gate_clementine_closed
        part_name = "clementine",
        orig_name = {"clementinetree:gate_closed", "clementinetree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Clementine Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_clementine", {
        -- From clementinetree/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_clementine.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.00004,
            seed = 3456,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
