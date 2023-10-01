---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_wirewood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_wirewood.init()

    return {
        description = "Wirewood tree",
    }

end

function unilib.pkg.tree_wirewood.exec()

    -- (no burnlevel)
    local sci_name = "Acacia coriacea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "wirewood",
        description = S("Wirewood Wood"),
    })

    unilib.register_node("unilib:tree_wirewood_trunk", "australia:wirewood_tree", mode, {
        -- From australia:wirewood_tree
        description = unilib.annotate(S("Wirewood Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_wirewood_trunk_top.png",
            "unilib_tree_wirewood_trunk_top.png",
            "unilib_tree_wirewood_trunk.png",
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
    })

    unilib.register_tree_wood({
        -- From australia:wirewood_wood. Creates unilib:tree_wirewood_wood
        part_name = "wirewood",
        orig_name = "australia:wirewood_wood",

        replace_mode = mode,
        description = S("Wirewood Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:wirewood_leaves. Creates unilib:tree_wirewood_leaves
        part_name = "wirewood",
        orig_name = "australia:wirewood_leaves",

        replace_mode = mode,
        description = S("Wirewood Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("wirewood")

    unilib.register_tree_sapling({
        -- From australia:wirewood_sapling. Creates unilib:tree_wirewood_sapling
        part_name = "wirewood",
        orig_name = "australia:wirewood_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Wirewood Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 12, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_wirewood_1", 3, 1, 3},
            {"unilib_tree_wirewood_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_wirewood_wood. Creates unilib:tree_wirewood_wood_fence
        part_name = "wirewood",
        orig_name = "australia:fence_wirewood_wood",

        replace_mode = mode,
        base_img = "unilib_tree_wirewood_wood.png",
        description = S("Wirewood Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_wirewood_wood_fence_rail
        part_name = "wirewood",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_wirewood_wood.png",
        description = S("Wirewood Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_wirewood_closed
        part_name = "wirewood",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Wirewood Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_wirewood_in_central_" .. i, {
            -- From australia/biome_central_australia.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_wirewood_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
