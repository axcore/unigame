---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_box_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_box_white.init()

    return {
        description = "White box tree",
        optional = "mushroom_brown",
    }

end

function unilib.pkg.tree_box_white.exec()

    local burnlevel = 2
    local sci_name = "Eucalyptus albens"

    unilib.register_tree({
        -- Original to unilib
        part_name = "box_white",
        description = S("White Box Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:white_box_tree. Creates unilib:tree_box_white_trunk
        part_name = "box_white",
        orig_name = "australia:white_box_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("White Box Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:white_box_wood. Creates unilib:tree_box_white_wood
        part_name = "box_white",
        orig_name = "australia:white_box_wood",

        replace_mode = mode,
        description = S("White Box Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:white_box_leaves. Creates unilib:tree_box_white_leaves
        part_name = "box_white",
        orig_name = "australia:white_box_leaves",

        replace_mode = mode,
        description = S("White Box Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("box_white")

    unilib.register_tree_sapling({
        -- From australia:white_box_sapling. Creates unilib:tree_box_white_sapling
        part_name = "box_white",
        orig_name = "australia:white_box_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("White Box Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 21, z = 8},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_tree_box_white_1", 6, 1, 6},
            {"unilib_tree_box_white_2", 7, 1, 7},
            {"unilib_tree_box_white_3", 8, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_box_white_wood. Creates unilib:tree_box_white_wood_fence
        part_name = "box_white",
        orig_name = "australia:fence_box_white_wood",

        replace_mode = mode,
        base_img = "unilib_tree_box_white_wood.png",
        description = S("White Box Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_box_white_wood_fence_rail
        part_name = "box_white",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_box_white_wood.png",
        description = S("White Box Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_box_white_closed, etc
        part_name = "box_white",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("White Box Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_box_white_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_box_white_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

    unilib.register_decoration_generic("australia_tree_box_white_log", {
        -- From australia/biome_victorian_forests.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_box_white_log.mts",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = 0.0018,
            persist = 0.66,
            scale = 0.0011,
            seed = 35,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
