---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_quandong_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_quandong_desert.init()

    return {
        description = "Desert quandong tree",
        notes = "Produces quandong fruits",
        depends = "fruit_quandong_desert",
    }

end

function unilib.pkg.tree_quandong_desert.exec()

    -- (no burnlevel)
    local sci_name = "Santalum acuminatum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "quandong_desert",
        description = S("Desert Quandong Wood"),
    })

    unilib.register_node("unilib:tree_quandong_desert_trunk", "australia:quandong_tree", mode, {
        -- From australia:quandong_tree
        description = unilib.annotate(S("Desert Quandong Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_quandong_desert_trunk_top.png",
            "unilib_tree_quandong_desert_trunk_top.png",
            "unilib_tree_quandong_desert_trunk.png",
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
        -- From australia:quandong_wood. Creates unilib:tree_quandong_desert_wood
        part_name = "quandong_desert",
        orig_name = "australia:quandong_wood",

        replace_mode = mode,
        description = S("Desert Quandong Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:quandong_leaves. Creates unilib:tree_quandong_desert_leaves
        part_name = "quandong_desert",
        orig_name = "australia:quandong_leaves",

        replace_mode = mode,
        description = S("Desert Quandong Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:quandong_leaves
        trunks = {"unilib:tree_quandong_desert_trunk"},
        leaves = {"unilib:tree_quandong_desert_leaves", "unilib:fruit_quandong_desert"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:quandong_sapling. Creates unilib:tree_quandong_desert_sapling
        part_name = "quandong_desert",
        orig_name = "australia:quandong_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Quandong Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 12, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_quandong_desert_1", 3, 1, 3},
            {"unilib_tree_quandong_desert_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_quandong_desert_wood. Creates unilib:tree_quandong_desert_wood_fence
        part_name = "quandong_desert",
        orig_name = "australia:fence_quandong_desert_wood",

        replace_mode = mode,
        base_img = "unilib_tree_quandong_desert_wood.png",
        description = S("Desert Quandong Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_quandong_desert_wood_fence_rail
        part_name = "quandong_desert",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_quandong_desert_wood.png",
        description = S("Desert Quandong Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_quandong_desert_closed
        part_name = "quandong_desert",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Desert Quandong Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_quandong_desert_in_central_" .. i, {
            -- From australia/biome_central_australia.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_quandong_desert_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_quandong_desert_in_goldfields_" .. i, {
            -- From australia/biome_goldfields_esperence.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_quandong_desert_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_quandong_desert_in_mulga_lands_" .. i, {
            -- From australia/biome_mulga_lands.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_quandong_desert_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_quandong_desert_in_murray_" .. i, {
            -- From australia/biome_murray_darling_basin.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_quandong_desert_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_quandong_desert_in_simpson_" .. i, {
            -- From australia/biome_simpson_desert.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_quandong_desert_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
