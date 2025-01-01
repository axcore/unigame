---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_wattle_golden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_wattle_golden.init()

    return {
        description = "Golden wattle tree",
    }

end

function unilib.pkg.tree_wattle_golden.exec()

    local burnlevel = 2
    local sci_name = "Acacia pycnantha"

    local node_box = {
        type = "fixed",
        fixed = {-0.165, -0.5, -0.165, 0.165, 0.5, 0.165},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "wattle_golden",
        description = S("Golden Wattle Wood"),

        slim_flag = true,
    })

    unilib.register_node("unilib:tree_wattle_golden_trunk", "australia:golden_wattle_tree", mode, {
        -- From australia:golden_wattle_tree
        description = unilib.utils.annotate(S("Golden Wattle Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_wattle_golden_trunk_top.png",
            "unilib_tree_wattle_golden_trunk_top.png",
            "unilib_tree_wattle_golden_trunk.png",
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
        -- Original to unilib. Creates unilib:tree_wattle_golden_trunk_stripped
        part_name = "wattle_golden",
        orig_name = nil,

        replace_mode = mode,
        description = S("Golden Wattle Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:golden_wattle_wood. Creates unilib:tree_wattle_golden_wood
        part_name = "wattle_golden",
        orig_name = "australia:golden_wattle_wood",

        replace_mode = mode,
        description = S("Golden Wattle Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:golden_wattle_leaves. Creates unilib:tree_wattle_golden_leaves
        part_name = "wattle_golden",
        orig_name = "australia:golden_wattle_leaves",

        replace_mode = mode,
        description = S("Golden Wattle Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("wattle_golden")

    unilib.register_tree_sapling({
        -- From australia:golden_wattle_sapling. Creates unilib:tree_wattle_golden_sapling
        part_name = "wattle_golden",
        orig_name = "australia:golden_wattle_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Golden Wattle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 10, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_tree_wattle_golden_1", 2, 1, 2},
            {"unilib_tree_wattle_golden_2", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_wattle_golden_wood. Creates unilib:tree_wattle_golden_wood_fence
        part_name = "wattle_golden",
        orig_name = "australia:fence_wattle_golden_wood",

        replace_mode = mode,
        base_img = "unilib_tree_wattle_golden_wood.png",
        description = S("Golden Wattle Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_wattle_golden_wood_fence_rail
        part_name = "wattle_golden",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_wattle_golden_wood.png",
        description = S("Golden Wattle Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_wattle_golden_closed, etc
        part_name = "wattle_golden",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Golden Wattle Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_wattle_golden_in_flinders_" .. i, {
            -- From australia/biome_flinders_lofty.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_wattle_golden_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_wattle_golden_in_murray_" .. i, {
            -- From australia/biome_murray_darling_basin.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_wattle_golden_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_wattle_golden_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_wattle_golden_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_wattle_golden_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_wattle_golden_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
