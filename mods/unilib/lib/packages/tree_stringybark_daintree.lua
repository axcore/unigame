---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_stringybark_daintree = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_stringybark_daintree.init()

    return {
        description = "Daintree stringybark tree",
    }

end

function unilib.pkg.tree_stringybark_daintree.exec()

    local burnlevel = 5
    local sci_name = "Eucalyptus pellita"

    unilib.register_tree({
        -- Original to unilib
        part_name = "stringybark_daintree",
        description = S("Daintree Stringybark Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:daintree_stringybark_tree. Creates unilib:tree_stringybark_daintree_trunk
        part_name = "stringybark_daintree",
        orig_name = "australia:daintree_stringybark_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Daintree Stringybark Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:daintree_stringybark_wood. Creates unilib:tree_stringybark_daintree_wood
        part_name = "stringybark_daintree",
        orig_name = "australia:daintree_stringybark_wood",

        replace_mode = mode,
        description = S("Daintree Stringybark Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:daintree_stringybark_leaves. Creates
        --      unilib:tree_stringybark_daintree_leaves
        part_name = "stringybark_daintree",
        orig_name = "australia:daintree_stringybark_leaves",

        replace_mode = mode,
        description = S("Daintree Stringybark Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("stringybark_daintree")

    unilib.register_tree_sapling({
        -- From australia:daintree_stringybark_sapling. Creates
        --      unilib:tree_stringybark_daintree_sapling
        part_name = "stringybark_daintree",
        orig_name = "australia:daintree_stringybark_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Daintree Stringybark Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 7, y = 31, z = 7},
        minp_table = {x = -7, y = 1, z = -7},
        schem_list = {
            {"unilib_tree_stringybark_daintree_1", 6, 1, 6},
            {"unilib_tree_stringybark_daintree_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_daintree_stringybark_wood. Creates
        --      unilib:tree_stringybark_daintree_wood_fence
        part_name = "stringybark_daintree",
        orig_name = "australia:fence_daintree_stringybark_wood",

        replace_mode = mode,
        base_img = "unilib_tree_stringybark_daintree_wood.png",
        description = S("Daintree Stringybark Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_stringybark_daintree_wood_fence_rail
        part_name = "stringybark_daintree",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_stringybark_daintree_wood.png",
        description = S("Daintree Stringybark Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_stringybark_daintree_closed, etc
        part_name = "stringybark_daintree",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Daintree Stringybark Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic(
            -- From australia/biome_far_north_queensland.lua
            "australia_tree_stringybark_daintree_in_queensland_" .. i,
                {
                deco_type = "schematic",
                schematic = unilib.core.path_mod ..
                        "/mts/unilib_tree_stringybark_daintree_" .. i .. ".mts",

                fill_ratio = (2 - i + 1) / 12000,
                flags = "place_center_x, place_center_z",
                rotation = "random",
                sidelen = 80,
            }
        )

    end

end
