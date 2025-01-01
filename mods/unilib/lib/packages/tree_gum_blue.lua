---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gum_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gum_blue.init()

    return {
        description = "Blue gum tree",
    }

end

function unilib.pkg.tree_gum_blue.exec()

    local burnlevel = 5
    local sci_name = "Eucalyptus globulus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "gum_blue",
        description = S("Blue Gum Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:blue_gum_tree. Creates unilib:tree_gum_blue_trunk
        part_name = "gum_blue",
        orig_name = "australia:blue_gum_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Blue Gum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:blue_gum_wood. Creates unilib:tree_gum_blue_wood
        part_name = "gum_blue",
        orig_name = "australia:blue_gum_wood",

        replace_mode = mode,
        description = S("Blue Gum Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:blue_gum_leaves. Creates unilib:tree_gum_blue_leaves
        part_name = "gum_blue",
        orig_name = "australia:blue_gum_leaves",

        replace_mode = mode,
        description = S("Blue Gum Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("gum_blue")

    unilib.register_tree_sapling({
        -- From australia:blue_gum_sapling. Creates unilib:tree_gum_blue_sapling
        part_name = "gum_blue",
        orig_name = "australia:blue_gum_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Blue Gum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 7, y = 36, z = 7},
        minp_table = {x = -7, y = 1, z = -7},
        schem_list = {
            {"unilib_tree_gum_blue_1", 6, 1, 6},
            {"unilib_tree_gum_blue_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_gum_blue_wood. Creates unilib:tree_gum_blue_wood_fence
        part_name = "gum_blue",
        orig_name = "australia:fence_gum_blue_wood",

        replace_mode = mode,
        base_img = "unilib_tree_gum_blue_wood.png",
        description = S("Blue Gum Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_gum_blue_wood_fence_rail
        part_name = "gum_blue",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_gum_blue_wood.png",
        description = S("Blue Gum Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_gum_blue_closed, etc
        part_name = "gum_blue",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Blue Gum Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_gum_blue_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_gum_blue_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 8000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_gum_blue_in_tasmania_" .. i, {
            -- From australia/biome_tasmania.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_gum_blue_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_gum_blue_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_gum_blue_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 7000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
