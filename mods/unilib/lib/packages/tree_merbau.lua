---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_merbau = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_merbau.init()

    return {
        description = "Merbau tree",
    }

end

function unilib.pkg.tree_merbau.exec()

    -- (no burnlevel)
    local sci_name = "Intsia bijuga"

    unilib.register_tree({
        -- Original to unilib
        part_name = "merbau",
        description = S("Merbau Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:merbau_tree. Creates unilib:tree_merbau_trunk
        part_name = "merbau",
        orig_name = "australia:merbau_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Merbau Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:merbau_wood. Creates unilib:tree_merbau_wood
        part_name = "merbau",
        orig_name = "australia:merbau_wood",

        replace_mode = mode,
        description = S("Merbau Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:merbau_leaves. Creates unilib:tree_merbau_leaves
        part_name = "merbau",
        orig_name = "australia:merbau_leaves",

        replace_mode = mode,
        description = S("Merbau Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("merbau")

    unilib.register_tree_sapling({
        -- From australia:merbau_sapling. Creates unilib:tree_merbau_sapling
        part_name = "merbau",
        orig_name = "australia:merbau_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Merbau Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 25, z = 8},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_tree_merbau_1", 8, 1, 8},
            {"unilib_tree_merbau_2", 8, 1, 8},
            {"unilib_tree_merbau_3", 8, 1, 8},
            {"unilib_tree_merbau_4", 8, 1, 8},
            {"unilib_tree_merbau_5", 8, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_merbau_wood. Creates unilib:tree_merbau_wood_fence
        part_name = "merbau",
        orig_name = "australia:fence_merbau_wood",

        replace_mode = mode,
        base_img = "unilib_tree_merbau_wood.png",
        description = S("Merbau Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_merbau_wood_fence_rail
        part_name = "merbau",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_merbau_wood.png",
        description = S("Merbau Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_merbau_closed
        part_name = "merbau",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Merbau Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 5 do

        unilib.register_decoration("australia_tree_merbau_in_queensland_" .. i, {
            -- From australia/biome_far_north_queensland.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_merbau_" .. i .. ".mts",

            fill_ratio = (5 - i + 1) / 6000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
