---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_banksia_coast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_banksia_coast.init()

    return {
        description = "Coast banksia tree",
    }

end

function unilib.pkg.tree_banksia_coast.exec()

    local burnlevel = 2
    local sci_name = "Banksia integrifolia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "banksia_coast",
        description = S("Coast Banksia Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:coast_banksia_tree. Creates unilib:tree_banksia_coast_trunk
        part_name = "banksia_coast",
        orig_name = "australia:coast_banksia_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Coast Banksia Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:coast_banksia_wood. Creates unilib:tree_banksia_coast_wood
        part_name = "banksia_coast",
        orig_name = "australia:coast_banksia_wood",

        replace_mode = mode,
        description = S("Coast Banksia Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:coast_banksia_leaves. Creates unilib:tree_banksia_coast_leaves
        part_name = "banksia_coast",
        orig_name = "australia:coast_banksia_leaves",

        replace_mode = mode,
        description = S("Coast Banksia Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("banksia_coast")

    unilib.register_tree_sapling({
        -- From australia:coast_banksia_sapling. Creates unilib:tree_banksia_coast_sapling
        part_name = "banksia_coast",
        orig_name = "australia:coast_banksia_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Coast Banksia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 19, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        schem_list = {
            {"unilib_tree_banksia_coast_1", 3, 1, 3},
            {"unilib_tree_banksia_coast_2", 4, 1, 4},
            {"unilib_tree_banksia_coast_3", 5, 1, 5},
            {"unilib_tree_banksia_coast_4", 6, 1, 6},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_banksia_coast_wood. Creates unilib:tree_banksia_coast_wood_fence
        part_name = "banksia_coast",
        orig_name = "australia:fence_banksia_coast_wood",

        replace_mode = mode,
        base_img = "unilib_tree_banksia_coast_wood.png",
        description = S("Coast Banksia Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_banksia_coast_wood_fence_rail
        part_name = "banksia_coast",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_banksia_coast_wood.png",
        description = S("Coast Banksia Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_banksia_coast_closed, etc
        part_name = "banksia_coast",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Coast Banksia Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_banksia_coast_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_banksia_coast_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 3, 4 do

        unilib.register_decoration_generic("australia_tree_banksia_coast_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_banksia_coast_" .. i .. ".mts",

            fill_ratio = (4 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
