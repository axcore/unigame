---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_huon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_huon.init()

    return {
        description = "Huon pine tree",
    }

end

function unilib.pkg.tree_pine_huon.exec()

    local burnlevel = 3
    local sci_name = "Lagarostrobos franklinii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_huon",
        description = S("Huon Pine Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:huon_pine_tree. Creates unilib:tree_pine_huon_trunk
        part_name = "pine_huon",
        orig_name = "australia:huon_pine_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Huon Pine Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:huon_pine_wood. Creates unilib:tree_pine_huon_wood
        part_name = "pine_huon",
        orig_name = "australia:huon_pine_wood",

        replace_mode = mode,
        description = S("Huon Pine Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:huon_pine_leaves. Creates unilib:tree_pine_huon_leaves
        part_name = "pine_huon",
        orig_name = "australia:huon_pine_leaves",

        replace_mode = mode,
        description = S("Huon Pine Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("pine_huon")

    unilib.register_tree_sapling({
        -- From australia:huon_pine_sapling. Creates unilib:tree_pine_huon_sapling
        part_name = "pine_huon",
        orig_name = "australia:huon_pine_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Huon Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 22, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 1, 4},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_pine_huon_wood. Creates unilib:tree_pine_huon_wood_fence
        part_name = "pine_huon",
        orig_name = "australia:fence_pine_huon_wood",

        replace_mode = mode,
        base_img = "unilib_tree_pine_huon_wood.png",
        description = S("Huon Pine Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pine_huon_wood_fence_rail
        part_name = "pine_huon",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pine_huon_wood.png",
        description = S("Huon Pine Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_pine_huon_closed, etc
        part_name = "pine_huon",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Huon Pine Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("australia_tree_pine_huon_in_tasmania", {
        -- From australia/biome_tasmania.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_huon.mts",

        fill_ratio = 1 / 15000,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
