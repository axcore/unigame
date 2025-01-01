---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mangrove_stilted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mangrove_stilted.init()

    return {
        description = "Stilted mangrove tree",
    }

end

function unilib.pkg.tree_mangrove_stilted.exec()

    local burnlevel = 2
    local sci_name = "Rhizophora stylosa"

    local node_box = {
        type = "fixed",
        fixed = {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "mangrove_stilted",
        description = S("Stilted Mangrove Wood"),

        slim_flag = true,
    })

    unilib.register_node(
        -- From australia:stilted_mangrove_tree
        "unilib:tree_mangrove_stilted_trunk",
        "australia:stilted_mangrove_tree",
        mode,
        {
            description = unilib.utils.annotate(S("Stilted Mangrove Tree Trunk"), sci_name),
            tiles = {
                "unilib_tree_mangrove_stilted_trunk_top.png",
                "unilib_tree_mangrove_stilted_trunk_top.png",
                "unilib_tree_mangrove_stilted_trunk.png",
            },
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = node_box,
            paramtype = "light",
            selection_box = node_box,

            on_place = core.rotate_node,
        }
    )

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_mangrove_stilted_trunk_stripped
        part_name = "mangrove_stilted",
        orig_name = nil,

        replace_mode = mode,
        description = S("Stilted Mangrove Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:stilted_mangrove_wood. Creates unilib:tree_mangrove_stilted_wood
        part_name = "mangrove_stilted",
        orig_name = "australia:stilted_mangrove_wood",

        replace_mode = mode,
        description = S("Stilted Mangrove Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:stilted_mangrove_leaves. Creates unilib:tree_mangrove_stilted_leaves
        part_name = "mangrove_stilted",
        orig_name = "australia:stilted_mangrove_leaves",

        replace_mode = mode,
        description = S("Stilted Mangrove Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("mangrove_stilted")

    unilib.register_tree_sapling({
        -- From australia:stilted_mangrove_sapling. Creates unilib:tree_mangrove_stilted_sapling
        part_name = "mangrove_stilted",
        orig_name = "australia:stilted_mangrove_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Stilted Mangrove Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 7, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_mangrove_stilted_1", 2, 1, 2},
            {"unilib_tree_mangrove_stilted_2", 2, 1, 2},
            {"unilib_tree_mangrove_stilted_3", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_mangrove_stilted_wood. Creates
        --      unilib:tree_mangrove_stilted_wood_fence
        part_name = "mangrove_stilted",
        orig_name = "australia:fence_mangrove_stilted_wood",

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_stilted_wood.png",
        description = S("Stilted Mangrove Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_mangrove_stilted_wood_fence_rail
        part_name = "mangrove_stilted",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_stilted_wood.png",
        description = S("Stilted Mangrove Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_mangrove_stilted_closed, etc
        part_name = "mangrove_stilted",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Stilted Mangrove Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_mangrove_stilted_in_mangroves_" .. i, {
            -- From australia/biome_mangroves.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_mangrove_stilted_" .. i .. ".mts",

            fill_ratio = 0.003,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
