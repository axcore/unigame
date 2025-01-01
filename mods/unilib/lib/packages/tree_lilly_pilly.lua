---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_lilly_pilly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_lilly_pilly.init()

    return {
        description = "Lilly Pilly tree",
        notes = "Produces lilly pilly berries",
        depends = "fruit_berry_lilly_pilly",
    }

end

function unilib.pkg.tree_lilly_pilly.exec()

    local burnlevel = 2
    local sci_name = "Syzygium smithii"

    local node_box = {
        type = "fixed",
        fixed = {-0.165, -0.5, -0.165, 0.165, 0.5, 0.165},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "lilly_pilly",
        description = S("Lilly Pilly Wood"),

        slim_flag = true,
    })

    unilib.register_node("unilib:tree_lilly_pilly_trunk", "australia:lilly_pilly_tree", mode, {
        -- From australia:lilly_pilly_tree
        description = unilib.utils.annotate(S("Lilly Pilly Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_lilly_pilly_trunk_top.png",
            "unilib_tree_lilly_pilly_trunk_top.png",
            "unilib_tree_lilly_pilly_trunk.png",
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
        -- Original to unilib. Creates unilib:tree_lilly_pilly_trunk_stripped
        part_name = "lilly_pilly",
        orig_name = nil,

        replace_mode = mode,
        description = S("Lilly Pilly Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:lilly_pilly_wood. Creates unilib:tree_lilly_pilly_wood
        part_name = "lilly_pilly",
        orig_name = "australia:lilly_pilly_wood",

        replace_mode = mode,
        description = S("Lilly Pilly Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:lilly_pilly_leaves. Creates unilib:tree_lilly_pilly_leaves
        part_name = "lilly_pilly",
        orig_name = "australia:lilly_pilly_leaves",

        replace_mode = mode,
        description = S("Lilly Pilly Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:lilly_pilly_leaves
        trunk_type = "lilly_pilly",
        trunks = {"unilib:tree_lilly_pilly_trunk"},
        leaves = {"unilib:tree_lilly_pilly_leaves"},
        others = {"unilib:fruit_berry_lilly_pilly"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:lilly_pilly_sapling. Creates unilib:tree_lilly_pilly_sapling
        part_name = "lilly_pilly",
        orig_name = "australia:lilly_pilly_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Lilly Pilly Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 19, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_lilly_pilly_1", 4, 1, 4},
            {"unilib_tree_lilly_pilly_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_lilly_pilly_wood. Creates unilib:tree_lilly_pilly_wood_fence
        part_name = "lilly_pilly",
        orig_name = "australia:fence_lilly_pilly_wood",

        replace_mode = mode,
        base_img = "unilib_tree_lilly_pilly_wood.png",
        description = S("Lilly Pilly Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_lilly_pilly_wood_fence_rail
        part_name = "lilly_pilly",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_lilly_pilly_wood.png",
        description = S("Lilly Pilly Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_lilly_pilly_closed, etc
        part_name = "lilly_pilly",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Lilly Pilly Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_lilly_pilly_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_lilly_pilly_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_lilly_pilly_in_queensland_" .. i, {
            -- From australia/biome_far_north_queensland.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_lilly_pilly_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_lilly_pilly_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_lilly_pilly_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_lilly_pilly_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_lilly_pilly_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
