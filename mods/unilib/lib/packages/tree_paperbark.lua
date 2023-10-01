---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_paperbark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_paperbark.init()

    return {
        description = "Paperbark tree",
    }

end

function unilib.pkg.tree_paperbark.exec()

    -- (no burnlevel)
    local sci_name = "Melaleuca quinquenervia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "paperbark",
        description = S("Paperbark Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:paperbark_tree. Creates unilib:tree_paperbark_trunk
        part_name = "paperbark",
        orig_name = "australia:paperbark_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Paperbark Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:paperbark_wood. Creates unilib:tree_paperbark_wood
        part_name = "paperbark",
        orig_name = "australia:paperbark_wood",

        replace_mode = mode,
        description = S("Paperbark Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:paperbark_leaves. Creates unilib:tree_paperbark_leaves
        part_name = "paperbark",
        orig_name = "australia:paperbark_leaves",

        replace_mode = mode,
        description = S("Paperbark Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("paperbark")

    unilib.register_tree_sapling({
        -- From australia:paperbark_sapling. Creates unilib:tree_paperbark_sapling
        part_name = "paperbark",
        orig_name = "australia:paperbark_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Paperbark Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 22, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_paperbark_1", 4, 1, 4},
            {"unilib_tree_paperbark_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_paperbark_wood. Creates unilib:tree_paperbark_wood_fence
        part_name = "paperbark",
        orig_name = "australia:fence_paperbark_wood",

        replace_mode = mode,
        base_img = "unilib_tree_paperbark_wood.png",
        description = S("Paperbark Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_paperbark_wood_fence_rail
        part_name = "paperbark",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_paperbark_wood.png",
        description = S("Paperbark Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_paperbark_closed
        part_name = "paperbark",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Paperbark Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_paperbark_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_paperbark_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
