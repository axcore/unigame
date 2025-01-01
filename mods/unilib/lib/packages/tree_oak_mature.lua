---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.oak.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak_mature.init()

    return {
        description = "Mature oak tree",
        notes = "Produces mature oak tree acorns",
        depends = "ingredient_acorn_oak_mature",
    }

end

function unilib.pkg.tree_oak_mature.exec()

    local burnlevel = 3
    local sci_name = "Quercus robur"

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak_mature",
        description = S("Mature Oak Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From oak:trunk. Creates unilib:tree_oak_mature_trunk
        part_name = "oak_mature",
        orig_name = "oak:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Oak Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From oak:wood. Creates unilib:tree_oak_mature_wood
        part_name = "oak_mature",
        orig_name = "oak:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Oak Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From oak:leaves. Creates unilib:tree_oak_mature_leaves
        part_name = "oak_mature",
        orig_name = "oak:leaves",

        replace_mode = mode,
        description = S("Mature Oak Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From oak:leaves
        trunk_type = "oak_mature",
        trunks = {"unilib:tree_oak_mature_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_oak_mature_leaves"},
        others = {"unilib:ingredient_acorn_oak_mature"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From oak:sapling. Creates unilib:tree_oak_mature_sapling
        part_name = "oak_mature",
        orig_name = "oak:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Oak Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {5, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From oak:fence. Creates unilib:tree_oak_mature_wood_fence
        part_name = "oak_mature",
        orig_name = "oak:fence",

        replace_mode = mode,
        base_img = "unilib_tree_oak_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Oak Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From oak:fence_rail. Creates unilib:tree_oak_mature_wood_fence_rail
        part_name = "oak_mature",
        orig_name = "oak:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_oak_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Oak Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From oak:gate_closed, etc. Creates unilib:gate_oak_mature_closed, etc
        part_name = "oak_mature",
        orig_name = {"oak:gate_closed", "oak:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Oak Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_oak_mature", {
        -- From oak/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_mature.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0008,
            persist = 0.66,
            scale = 0.00004,
            seed = 6431,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
