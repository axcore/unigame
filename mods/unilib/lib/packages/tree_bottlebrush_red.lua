---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_bottlebrush_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_bottlebrush_red.init()

    return {
        description = "Red Bottlebrush tree",
    }

end

function unilib.pkg.tree_bottlebrush_red.exec()

    -- (no burnlevel)
    local sci_name = "Melaleuca citrina"

    unilib.register_tree({
        -- Original to unilib
        part_name = "bottlebrush_red",
        description = S("Red Bottlebrush Wood"),
    })

    unilib.register_node(
        -- From australia:red_bottlebrush_tree
        "unilib:tree_bottlebrush_red_trunk",
        "australia:red_bottlebrush_tree",
        mode,
        {
            description = unilib.annotate(S("Red Bottlebrush Tree Trunk"), sci_name),
            tiles = {
                "unilib_tree_bottlebrush_red_trunk_top.png",
                "unilib_tree_bottlebrush_red_trunk_top.png",
                "unilib_tree_bottlebrush_red_trunk.png",
            },
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
            sounds = unilib.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.165, -0.5, -0.165, 0.165, 0.5, 0.165},
            },
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.165, -0.5, -0.165, 0.165, 0.5, 0.165},
            },

            on_place = minetest.rotate_node,
        }
    )

    unilib.register_tree_wood({
        -- From australia:red_bottlebrush_wood. Creates unilib:tree_bottlebrush_red_wood
        part_name = "bottlebrush_red",
        orig_name = "australia:red_bottlebrush_wood",

        replace_mode = mode,
        description = S("Red Bottlebrush Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:red_bottlebrush_leaves. Creates unilib:tree_bottlebrush_red_leaves
        part_name = "bottlebrush_red",
        orig_name = "australia:red_bottlebrush_leaves",

        replace_mode = mode,
        description = S("Red Bottlebrush Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("bottlebrush_red")

    unilib.register_tree_sapling({
        -- From australia:red_bottlebrush_sapling. Creates unilib:tree_bottlebrush_red_sapling
        part_name = "bottlebrush_red",
        orig_name = "australia:red_bottlebrush_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Red Bottlebrush Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 11, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_tree_bottlebrush_red_1", 2, 1, 2},
            {"unilib_tree_bottlebrush_red_2", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_bottlebrush_red_wood. Creates unilib:tree_bottlebrush_red_wood_fence
        part_name = "bottlebrush_red",
        orig_name = "australia:fence_bottlebrush_red_wood",

        replace_mode = mode,
        base_img = "unilib_tree_bottlebrush_red_wood.png",
        description = S("Red Bottlebrush Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_bottlebrush_red_wood_fence_rail
        part_name = "bottlebrush_red",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_bottlebrush_red_wood.png",
        description = S("Red Bottlebrush Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_bottlebrush_red_closed
        part_name = "bottlebrush_red",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Red Bottlebrush Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_bottlebrush_red_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_bottlebrush_red_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_bottlebrush_red_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_bottlebrush_red_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
