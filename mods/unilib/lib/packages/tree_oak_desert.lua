---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak_desert.init()

    return {
        description = "Desert oak tree",
    }

end

function unilib.pkg.tree_oak_desert.exec()

    -- (no burnlevel)
    local sci_name = "Allocasuarina decaisneana"

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak_desert",
        description = S("Desert Oak Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:desert_oak_tree. Creates unilib:tree_oak_desert_trunk
        part_name = "oak_desert",
        orig_name = "australia:desert_oak_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Oak Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:desert_oak_wood. Creates unilib:tree_oak_desert_wood
        part_name = "oak_desert",
        orig_name = "australia:desert_oak_wood",

        replace_mode = mode,
        description = S("Desert Oak Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:desert_oak_leaves. Creates unilib:tree_oak_desert_leaves
        part_name = "oak_desert",
        orig_name = "australia:desert_oak_leaves",

        replace_mode = mode,
        description = S("Desert Oak Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("oak_desert")

    unilib.register_tree_sapling({
        -- From australia:desert_oak_sapling. Creates unilib:tree_oak_desert_sapling
        part_name = "oak_desert",
        orig_name = "australia:desert_oak_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Desert Oak Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 18, z = 8},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_tree_oak_desert_1", 6, 1, 6},
            {"unilib_tree_oak_desert_2", 7, 1, 7},
            {"unilib_tree_oak_desert_3", 8, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_oak_desert_wood. Creates unilib:tree_oak_desert_wood_fence
        part_name = "oak_desert",
        orig_name = "australia:fence_oak_desert_wood",

        replace_mode = mode,
        base_img = "unilib_tree_oak_desert_wood.png",
        description = S("Desert Oak Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_oak_desert_wood_fence_rail
        part_name = "oak_desert",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_oak_desert_wood.png",
        description = S("Desert Oak Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_oak_desert_closed
        part_name = "oak_desert",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Desert Oak Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration("australia_tree_oak_desert_in_central_" .. i, {
            -- From australia/biome_central_australia.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_oak_desert_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 3 do

        unilib.register_decoration("australia_tree_oak_desert_in_pilbara_" .. i, {
            -- From australia/biome_pilbara.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_oak_desert_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
