---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_paperbark_swamp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_paperbark_swamp.init()

    return {
        description = "Swamp paperbark tree",
    }

end

function unilib.pkg.tree_paperbark_swamp.exec()

    local burnlevel = 2
    local sci_name = "Melaleuca rhaphiophylla"

    local node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "paperbark_swamp",
        description = S("Swamp Paperbark Wood"),

        slim_flag = true,
    })

    unilib.register_node(
        -- From australia:swamp_paperbark_tree
        "unilib:tree_paperbark_swamp_trunk",
        "australia:swamp_paperbark_tree",
        mode,
        {
            description = unilib.utils.annotate(S("Swamp Paperbark Tree Trunk"), sci_name),
            tiles = {
                "unilib_tree_paperbark_swamp_trunk_top.png",
                "unilib_tree_paperbark_swamp_trunk_top.png",
                "unilib_tree_paperbark_swamp_trunk.png",
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
        -- Original to unilib. Creates unilib:tree_paperbark_swamp_trunk_stripped
        part_name = "paperbark_swamp",
        orig_name = nil,

        replace_mode = mode,
        description = S("Swamp Paperbark Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:swamp_paperbark_wood. Creates unilib:tree_paperbark_swamp_wood
        part_name = "paperbark_swamp",
        orig_name = "australia:swamp_paperbark_wood",

        replace_mode = mode,
        description = S("Swamp Paperbark Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:swamp_paperbark_leaves. Creates unilib:tree_paperbark_swamp_leaves
        part_name = "paperbark_swamp",
        orig_name = "australia:swamp_paperbark_leaves",

        replace_mode = mode,
        description = S("Swamp Paperbark Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("paperbark_swamp")

    unilib.register_tree_sapling({
        -- From australia:swamp_paperbark_sapling. Creates unilib:tree_paperbark_swamp_sapling
        part_name = "paperbark_swamp",
        orig_name = "australia:swamp_paperbark_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Swamp Paperbark Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 23, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_paperbark_swamp_1", 4, 1, 4},
            {"unilib_tree_paperbark_swamp_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_paperbark_swamp_wood. Creates unilib:tree_paperbark_swamp_wood_fence
        part_name = "paperbark_swamp",
        orig_name = "australia:fence_paperbark_swamp_wood",

        replace_mode = mode,
        base_img = "unilib_tree_paperbark_swamp_wood.png",
        description = S("Swamp Paperbark Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_paperbark_swamp_wood_fence_rail
        part_name = "paperbark_swamp",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_paperbark_swamp_wood.png",
        description = S("Swamp Paperbark Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_paperbark_swamp_closed, etc
        part_name = "paperbark_swamp",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Swamp Paperbark Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_paperbark_swamp_in_forests_" .. i, {
            -- From australia/biome_jarrah_karri_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_paperbark_swamp_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
