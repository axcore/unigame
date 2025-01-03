---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_flame_illawarra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_flame_illawarra.init()

    return {
        description = "Illawarra Flame tree",
    }

end

function unilib.pkg.tree_flame_illawarra.exec()

    local burnlevel = 3
    local sci_name = "Brachychiton acerifolius"

    unilib.register_tree({
        -- Original to unilib
        part_name = "flame_illawarra",
        description = S("Illawarra Flame Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:illawarra_flame_tree. Creates unilib:tree_flame_illawarra_trunk
        part_name = "flame_illawarra",
        orig_name = "australia:illawarra_flame_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Illawarra Flame Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:illawarra_flame_wood. Creates unilib:tree_flame_illawarra_wood
        part_name = "flame_illawarra",
        orig_name = "australia:illawarra_flame_wood",

        replace_mode = mode,
        description = S("Illawarra Flame Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:illawarra_flame_leaves. Creates unilib:tree_flame_illawarra_leaves
        part_name = "flame_illawarra",
        orig_name = "australia:illawarra_flame_leaves",

        replace_mode = mode,
        description = S("Illawarra Flame Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("flame_illawarra")

    unilib.register_tree_sapling({
        -- From australia:illawarra_flame_sapling. Creates unilib:tree_flame_illawarra_sapling
        part_name = "flame_illawarra",
        orig_name = "australia:illawarra_flame_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Illawarra Flame Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 16, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_tree_flame_illawarra_1", 5, 1, 5},
            {"unilib_tree_flame_illawarra_2", 6, 1, 6},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_flame_illawarra_wood. Creates unilib:tree_flame_illawarra_wood_fence
        part_name = "flame_illawarra",
        orig_name = "australia:fence_flame_illawarra_wood",

        replace_mode = mode,
        base_img = "unilib_tree_flame_illawarra_wood.png",
        description = S("Illawarra Flame Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_flame_illawarra_wood_fence_rail
        part_name = "flame_illawarra",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_flame_illawarra_wood.png",
        description = S("Illawarra Flame Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_flame_illawarra_closed, etc
        part_name = "flame_illawarra",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Illawarra Flame Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_flame_illawarra_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_flame_illawarra_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
