---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gum_scribbly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gum_scribbly.init()

    return {
        description = "Scribbly gum tree",
    }

end

function unilib.pkg.tree_gum_scribbly.exec()

    local burnlevel = 2
    local sci_name = "Eucalyptus haemastoma"

    unilib.register_tree({
        -- Original to unilib
        part_name = "gum_scribbly",
        description = S("Scribbly Gum Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:scribbly_gum_tree. Creates unilib:tree_gum_scribbly_trunk
        part_name = "gum_scribbly",
        orig_name = "australia:scribbly_gum_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Scribbly Gum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:scribbly_gum_wood. Creates unilib:tree_gum_scribbly_wood
        part_name = "gum_scribbly",
        orig_name = "australia:scribbly_gum_wood",

        replace_mode = mode,
        description = S("Scribbly Gum Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:scribbly_gum_leaves. Creates unilib:tree_gum_scribbly_leaves
        part_name = "gum_scribbly",
        orig_name = "australia:scribbly_gum_leaves",

        replace_mode = mode,
        description = S("Scribbly Gum Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("gum_scribbly")

    unilib.register_tree_sapling({
        -- From australia:scribbly_gum_sapling. Creates unilib:tree_gum_scribbly_sapling
        part_name = "gum_scribbly",
        orig_name = "australia:scribbly_gum_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Scribbly Gum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 16, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_gum_scribbly_1", 4, 1, 4},
            {"unilib_tree_gum_scribbly_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_gum_scribbly_wood. Creates unilib:tree_gum_scribbly_wood_fence
        part_name = "gum_scribbly",
        orig_name = "australia:fence_gum_scribbly_wood",

        replace_mode = mode,
        base_img = "unilib_tree_gum_scribbly_wood.png",
        description = S("Scribbly Gum Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_gum_scribbly_wood_fence_rail
        part_name = "gum_scribbly",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_gum_scribbly_wood.png",
        description = S("Scribbly Gum Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_gum_scribbly_closed, etc
        part_name = "gum_scribbly",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Scribbly Gum Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_gum_scribbly_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_gum_scribbly_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
