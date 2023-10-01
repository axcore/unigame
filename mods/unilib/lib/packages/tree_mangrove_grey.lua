---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mangrove_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mangrove_grey.init()

    return {
        description = "Grey mangrove tree",
    }

end

function unilib.pkg.tree_mangrove_grey.exec()

    -- (no burnlevel)
    local sci_name = "Avicennia marina"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mangrove_grey",
        description = S("Grey Mangrove Wood"),
    })

    unilib.register_node("unilib:tree_mangrove_grey_trunk", "australia:grey_mangrove_tree", mode, {
        -- From australia:grey_mangrove_tree
        description = unilib.annotate(S("Grey Mangrove Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_mangrove_grey_trunk_top.png",
            "unilib_tree_mangrove_grey_trunk_top.png",
            "unilib_tree_mangrove_grey_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
        },

        on_place = minetest.rotate_node,
    })

    unilib.register_tree_wood({
        -- From australia:grey_mangrove_wood. Creates unilib:tree_mangrove_grey_wood
        part_name = "mangrove_grey",
        orig_name = "australia:grey_mangrove_wood",

        replace_mode = mode,
        description = S("Grey Mangrove Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:grey_mangrove_leaves. Creates unilib:tree_mangrove_grey_leaves
        part_name = "mangrove_grey",
        orig_name = "australia:grey_mangrove_leaves",

        replace_mode = mode,
        description = S("Grey Mangrove Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("mangrove_grey")

    unilib.register_tree_sapling({
        -- From australia:grey_mangrove_sapling. Creates unilib:tree_mangrove_grey_sapling
        part_name = "mangrove_grey",
        orig_name = "australia:grey_mangrove_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Grey Mangrove Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 7, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_mangrove_grey_1", 2, 1, 2},
            {"unilib_tree_mangrove_grey_2", 2, 1, 2},
            {"unilib_tree_mangrove_grey_3", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_mangrove_grey_wood. Creates unilib:tree_mangrove_grey_wood_fence
        part_name = "mangrove_grey",
        orig_name = "australia:fence_mangrove_grey_wood",

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_grey_wood.png",
        description = S("Grey Mangrove Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_mangrove_grey_wood_fence_rail
        part_name = "mangrove_grey",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_grey_wood.png",
        description = S("Grey Mangrove Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_mangrove_grey_closed
        part_name = "mangrove_grey",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Grey Mangrove Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration("australia_tree_mangrove_grey_in_mangroves_" .. i, {
            -- From australia/biome_mangroves.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_mangrove_grey_" .. i .. ".mts",

            fill_ratio = 0.003,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
