---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_eucalyptus_lemon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_eucalyptus_lemon.init()

    return {
        description = "Lemon eucalyptus tree",
    }

end

function unilib.pkg.tree_eucalyptus_lemon.exec()

    local burnlevel = 2
    local sci_name = "Eucalyptus citriodora"

    unilib.register_tree({
        -- Original to unilib
        part_name = "eucalyptus_lemon",
        description = S("Lemon Eucalyptus Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:lemon_eucalyptus_tree. Creates unilib:tree_eucalyptus_lemon_trunk
        part_name = "eucalyptus_lemon",
        orig_name = "australia:lemon_eucalyptus_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Lemon Eucalyptus Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:lemon_eucalyptus_wood. Creates unilib:tree_eucalyptus_lemon_wood
        part_name = "eucalyptus_lemon",
        orig_name = "australia:lemon_eucalyptus_wood",

        replace_mode = mode,
        description = S("Lemon Eucalyptus Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:lemon_eucalyptus_leaves. Creates unilib:tree_eucalyptus_lemon_leaves
        part_name = "eucalyptus_lemon",
        orig_name = "australia:lemon_eucalyptus_leaves",

        replace_mode = mode,
        description = S("Lemon Eucalyptus Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("eucalyptus_lemon")

    unilib.register_tree_sapling({
        -- From australia:lemon_eucalyptus_sapling. Creates unilib:tree_eucalyptus_lemon_sapling
        part_name = "eucalyptus_lemon",
        orig_name = "australia:lemon_eucalyptus_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Lemon Eucalyptus Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 24, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_eucalyptus_lemon_1", 4, 1, 4},
            {"unilib_tree_eucalyptus_lemon_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_eucalyptus_lemon_wood. Creates
        --      unilib:tree_eucalyptus_lemon_wood_fence
        part_name = "eucalyptus_lemon",
        orig_name = "australia:fence_eucalyptus_lemon_wood",

        replace_mode = mode,
        base_img = "unilib_tree_eucalyptus_lemon_wood.png",
        description = S("Lemon Eucalyptus Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_eucalyptus_lemon_wood_fence_rail
        part_name = "eucalyptus_lemon",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_eucalyptus_lemon_wood.png",
        description = S("Lemon Eucalyptus Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_eucalyptus_lemon_closed, etc
        part_name = "eucalyptus_lemon",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Lemon Eucalyptus Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_eucalyptus_lemon_in_queensland_" .. i, {
            -- From australia/biome_far_north_queensland.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_eucalyptus_lemon_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
