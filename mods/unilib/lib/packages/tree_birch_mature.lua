---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_birch_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.birch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_birch_mature.init()

    return {
        description = "Mature birch tree",
    }

end

function unilib.pkg.tree_birch_mature.exec()

    local burnlevel = 3
    local sci_name = "Betula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "birch_mature",
        description = S("Mature Birch Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From birch:trunk. Creates unilib:tree_birch_mature_trunk
        part_name = "birch_mature",
        orig_name = "birch:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Birch Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From birch:wood. Creates unilib:tree_birch_mature_wood
        part_name = "birch_mature",
        orig_name = "birch:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Birch Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From birch:leaves. Creates unilib:tree_birch_mature_leaves
        part_name = "birch_mature",
        orig_name = "birch:leaves",

        replace_mode = mode,
        description = S("Mature Birch Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("birch_mature")

    unilib.register_tree_sapling({
        -- From birch:sapling. Creates unilib:tree_birch_mature_sapling
        part_name = "birch_mature",
        orig_name = "birch:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mature Birch Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. one trunk spawns underground. No other tree from the cool_trees modpack does this
        --      (except sequoia), so tweak its offsets
--      offset_list = {2, 1, 2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From birch:fence. Creates unilib:tree_birch_mature_wood_fence
        part_name = "birch_mature",
        orig_name = "birch:fence",

        replace_mode = mode,
        base_img = "unilib_tree_birch_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Birch Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From birch:fence_rail. Creates unilib:tree_birch_mature_wood_fence_rail
        part_name = "birch_mature",
        orig_name = "birch:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_birch_mature_wood.png",
        burnlevel = burnlevel,
        description = S("Mature Birch Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From birch:gate. Creates unilib:gate_birch_mature_closed, etc
        part_name = "birch_mature",
        orig_name = {"birch:gate_closed", "birch:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mature Birch Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_birch_mature", {
        -- From birch/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_birch_mature.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.008,
            persist = 0.67,
            scale = 0.001,
            seed = 32,
            spread = {x = 255, y = 255, z = 255},
        },
        place_offset_y = 1,
        sidelen = 16,
    })

end
