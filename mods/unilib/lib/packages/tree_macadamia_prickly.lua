---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_macadamia_prickly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_macadamia_prickly.init()

    return {
        description = "Prickly macadamia tree",
        notes = "Produces macadamia nuts",
        depends = "food_nuts_macadamia",
    }

end

function unilib.pkg.tree_macadamia_prickly.exec()

    local burnlevel = 2
    local sci_name = "Macadamia tetraphylla"

    unilib.register_tree({
        -- Original to unilib
        part_name = "macadamia_prickly",
        description = S("Prickly Macadamia Wood"),
    })

    unilib.register_node("unilib:tree_macadamia_prickly_trunk", "australia:macadamia_tree", mode, {
        -- From australia:macadamia_tree
        description = unilib.utils.annotate(S("Prickly Macadamia Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_macadamia_prickly_trunk_top.png",
            "unilib_tree_macadamia_prickly_trunk_top.png",
            "unilib_tree_macadamia_prickly_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
        },

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_macadamia_prickly_trunk_stripped
        part_name = "macadamia_prickly",
        orig_name = nil,

        replace_mode = mode,
        description = S("Prickly Macadamia Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
    })

    unilib.register_tree_wood({
        -- From australia:macadamia_wood. Creates unilib:tree_macadamia_prickly_wood
        part_name = "macadamia_prickly",
        orig_name = "australia:macadamia_wood",

        replace_mode = mode,
        description = S("Prickly Macadamia Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:macadamia_leaves. Creates unilib:tree_macadamia_prickly_leaves
        part_name = "macadamia_prickly",
        orig_name = "australia:macadamia_leaves",

        replace_mode = mode,
        description = S("Prickly Macadamia Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:macadamia_leaves
        trunk_type = "macadamia_prickly",
        trunks = {"unilib:tree_macadamia_prickly_trunk"},
        leaves = {"unilib:tree_macadamia_prickly_leaves"},
        others = {"unilib:food_nuts_macadamia"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:macadamia_sapling. Creates unilib:tree_macadamia_prickly_sapling
        part_name = "macadamia_prickly",
        orig_name = "australia:macadamia_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Prickly Macadamia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 16, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_tree_macadamia_prickly_1", 4, 1, 4},
            {"unilib_tree_macadamia_prickly_2", 5, 1, 5},
            {"unilib_tree_macadamia_prickly_3", 6, 1, 6},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_macadamia_prickly_wood. Creates
        --      unilib:tree_macadamia_prickly_wood_fence
        part_name = "macadamia_prickly",
        orig_name = "australia:fence_macadamia_prickly_wood",

        replace_mode = mode,
        base_img = "unilib_tree_macadamia_prickly_wood.png",
        description = S("Prickly Macadamia Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_macadamia_prickly_wood_fence_rail
        part_name = "macadamia_prickly",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_macadamia_prickly_wood.png",
        description = S("Prickly Macadamia Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_macadamia_prickly_closed, etc
        part_name = "macadamia_prickly",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Prickly Macadamia Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_macadamia_prickly_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic =
                    unilib.core.path_mod .. "/mts/unilib_tree_macadamia_prickly_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
