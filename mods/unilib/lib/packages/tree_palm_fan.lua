---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_fan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_fan.init()

    return {
        description = "Australian fan palm tree",
    }

end

function unilib.pkg.tree_palm_fan.exec()

    local burnlevel = 2
    local sci_name = "Licuala ramsayi"

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_fan",
        description = S("Australian Fan Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:fan_palm_tree. Creates unilib:tree_palm_fan_trunk
        part_name = "palm_fan",
        orig_name = "australia:fan_palm_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Australian Fan Palm Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:fan_palm_wood. Creates unilib:tree_palm_fan_wood
        part_name = "palm_fan",
        orig_name = "australia:fan_palm_wood",

        replace_mode = mode,
        description = S("Australian Fan Palm Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:fan_palm_leaves. Creates unilib:tree_palm_fan_leaves
        part_name = "palm_fan",
        orig_name = "australia:fan_palm_leaves",

        replace_mode = mode,
        description = S("Australian Fan Palm Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("palm_fan")

    unilib.register_tree_sapling({
        -- From australia:fan_palm_sapling. Creates unilib:tree_palm_fan_sapling
        part_name = "palm_fan",
        orig_name = "australia:fan_palm_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Australian Fan Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 19, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        offset_list = {3, 1, 3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_palm_fan_wood. Creates unilib:tree_palm_fan_wood_fence
        part_name = "palm_fan",
        orig_name = "australia:fence_palm_fan_wood",

        replace_mode = mode,
        base_img = "unilib_tree_palm_fan_wood.png",
        description = S("Australian Fan Palm Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_palm_fan_wood_fence_rail
        part_name = "palm_fan",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_palm_fan_wood.png",
        description = S("Australian Fan Palm Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_palm_fan_closed, etc
        part_name = "palm_fan",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Australian Fan Palm Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("australia_tree_palm_fan_in_queensland", {
        -- From australia/biome_far_north_queensland.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_palm_fan.mts",

        fill_ratio = 1 / 300,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
