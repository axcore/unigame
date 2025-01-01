---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cherry_australian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cherry_australian.init()

    return {
        description = "Australian cherry tree",
        notes = "Produces Australian cherry tree cherries",
        depends = "fruit_cherry_australian",
    }

end

function unilib.pkg.tree_cherry_australian.exec()

    local burnlevel = 2
    local sci_name = "Exocarpos cupressiformis"

    local node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "cherry_australian",
        description = S("Australian Cherry Tree Wood"),

        slim_flag = true,
    })

    unilib.register_node("unilib:tree_cherry_australian_trunk", "australia:cherry_tree", mode, {
        -- From australia:cherry_tree
        description = unilib.utils.annotate(S("Australian Cherry Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_cherry_australian_trunk_top.png",
            "unilib_tree_cherry_australian_trunk_top.png",
            "unilib_tree_cherry_australian_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        selection_box = node_box,

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_cherry_australian_trunk_stripped
        part_name = "cherry_australian",
        orig_name = nil,

        replace_mode = mode,
        description = S("Australian Cherry Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:cherry_wood. Creates unilib:tree_cherry_australian_wood
        part_name = "cherry_australian",
        orig_name = "australia:cherry_wood",

        replace_mode = mode,
        description = S("Australian Cherry Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:cherry_leaves. Creates unilib:tree_cherry_australian_leaves
        part_name = "cherry_australian",
        orig_name = "australia:cherry_leaves",

        replace_mode = mode,
        description = S("Australian Cherry Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:cherry_leaves
        trunk_type = "cherry_australian",
        trunks = {"unilib:tree_cherry_australian_trunk"},
        leaves = {"unilib:tree_cherry_australian_leaves"},
        others = {"unilib:fruit_cherry_australian"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:cherry_sapling. Creates unilib:tree_cherry_australian_sapling
        part_name = "cherry_australian",
        orig_name = "australia:cherry_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Australian Cherry Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 11, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_cherry_australian_1", 2, 1, 2},
            {"unilib_tree_cherry_australian_2", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_cherry_australian_wood. Creates
        --      unilib:tree_cherry_australian_wood_fence
        part_name = "cherry_australian",
        orig_name = "australia:fence_cherry_australian_wood",

        replace_mode = mode,
        base_img = "unilib_tree_cherry_australian_wood.png",
        description = S("Australian Cherry Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_cherry_australian_wood_fence_rail
        part_name = "cherry_australian",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_cherry_australian_wood.png",
        description = S("Australian Cherry Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_cherry_australian_closed, etc
        part_name = "cherry_australian",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Australian Cherry Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_cherry_australian_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_cherry_australian_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_cherry_australian_in_flinders_" .. i, {
            -- From australia/biome_flinders_lofty.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_cherry_australian_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_cherry_australian_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_cherry_australian_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
