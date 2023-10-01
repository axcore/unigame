---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_acacia_shoestring = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_acacia_shoestring.init()

    return {
        description = "Shoestring acacia tree",
    }

end

function unilib.pkg.tree_acacia_shoestring.exec()

    -- (no burnlevel)
    local sci_name = "Acacia stenophylla"

    unilib.register_tree({
        -- Original to unilib
        part_name = "acacia_shoestring",
        description = S("Shoestring Acacia Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:shoestring_acacia_tree. Creates unilib:tree_acacia_shoestring_trunk
        part_name = "acacia_shoestring",
        orig_name = "australia:shoestring_acacia_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Shoestring Acacia Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:shoestring_acacia_wood. Creates unilib:tree_acacia_shoestring_wood
        part_name = "acacia_shoestring",
        orig_name = "australia:shoestring_acacia_wood",

        replace_mode = mode,
        description = S("Shoestring Acacia Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:shoestring_acacia_leaves. Creates unilib:tree_acacia_shoestring_leaves
        part_name = "acacia_shoestring",
        orig_name = "australia:shoestring_acacia_leaves",

        replace_mode = mode,
        description = S("Shoestring Acacia Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("acacia_shoestring")

    unilib.register_tree_sapling({
        -- From australia:shoestring_acacia_sapling. Creates unilib:tree_acacia_shoestring_sapling
        part_name = "acacia_shoestring",
        orig_name = "australia:shoestring_acacia_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Shoestring Acacia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 15, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_tree_acacia_shoestring_1", 2, 1, 2},
            {"unilib_tree_acacia_shoestring_2", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_shoestring_acacia_wood. Creates
        --      unilib:tree_acacia_shoestring_wood_fence
        part_name = "acacia_shoestring",
        orig_name = "australia:fence_shoestring_acacia_wood",

        replace_mode = mode,
        base_img = "unilib_tree_acacia_shoestring_wood.png",
        description = S("Shoestring Acacia Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_acacia_shoestring_wood_fence_rail
        part_name = "acacia_shoestring",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_acacia_shoestring_wood.png",
        description = S("Shoestring Acacia Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_acacia_shoestring_closed
        part_name = "acacia_shoestring",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Shoestring Acacia Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_acacia_shoestring_in_mulga_lands_" .. i, {
            -- From australia/biome_mulga_lands.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_acacia_shoestring_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
