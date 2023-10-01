---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gum_sugar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gum_sugar.init()

    return {
        description = "Sugar gum tree",
    }

end

function unilib.pkg.tree_gum_sugar.exec()

    -- (no burnlevel)
    local sci_name = "Eucalyptus cladocalyx"

    unilib.register_tree({
        -- Original to unilib
        part_name = "gum_sugar",
        description = S("Sugar Gum Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:sugar_gum_tree. Creates unilib:tree_gum_sugar_trunk
        part_name = "gum_sugar",
        orig_name = "australia:sugar_gum_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Sugar Gum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:sugar_gum_wood. Creates unilib:tree_gum_sugar_wood
        part_name = "gum_sugar",
        orig_name = "australia:sugar_gum_wood",

        replace_mode = mode,
        description = S("Sugar Gum Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:sugar_gum_leaves. Creates unilib:tree_gum_sugar_leaves
        part_name = "gum_sugar",
        orig_name = "australia:sugar_gum_leaves",

        replace_mode = mode,
        description = S("Sugar Gum Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("gum_sugar")

    unilib.register_tree_sapling({
        -- From australia:sugar_gum_sapling. Creates unilib:tree_gum_sugar_sapling
        part_name = "gum_sugar",
        orig_name = "australia:sugar_gum_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Sugar Gum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 11, y = 30, z = 11},
        minp_table = {x = -11, y = 1, z = -11},
        schem_list = {
            {"unilib_tree_gum_sugar_1", 9, 1, 9},
            {"unilib_tree_gum_sugar_2", 10, 1, 10},
            {"unilib_tree_gum_sugar_3", 11, 1, 11},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_gum_sugar_wood. Creates unilib:tree_gum_sugar_wood_fence
        part_name = "gum_sugar",
        orig_name = "australia:fence_gum_sugar_wood",

        replace_mode = mode,
        base_img = "unilib_tree_gum_sugar_wood.png",
        description = S("Sugar Gum Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_gum_sugar_wood_fence_rail
        part_name = "gum_sugar",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_gum_sugar_wood.png",
        description = S("Sugar Gum Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_gum_sugar_closed
        part_name = "gum_sugar",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Sugar Gum Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration("australia_tree_gum_sugar_in_central_" .. i, {
            -- From australia/biome_central_australia.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_gum_sugar_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 3 do

        unilib.register_decoration("australia_tree_gum_sugar_in_flinders_" .. i, {
            -- From australia/biome_flinders_lofty.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_gum_sugar_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
