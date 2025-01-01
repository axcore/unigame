---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jarrah = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jarrah.init()

    return {
        description = "Jarrah tree",
    }

end

function unilib.pkg.tree_jarrah.exec()

    local burnlevel = 4
    local sci_name = "Eucalyptus marginata"

    unilib.register_tree({
        -- Original to unilib
        part_name = "jarrah",
        description = S("Jarrah Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:jarrah_tree. Creates unilib:tree_jarrah_trunk
        part_name = "jarrah",
        orig_name = "australia:jarrah_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Jarrah Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:jarrah_wood. Creates unilib:tree_jarrah_wood
        part_name = "jarrah",
        orig_name = "australia:jarrah_wood",

        replace_mode = mode,
        description = S("Jarrah Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:jarrah_leaves. Creates unilib:tree_jarrah_leaves
        part_name = "jarrah",
        orig_name = "australia:jarrah_leaves",

        replace_mode = mode,
        description = S("Jarrah Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("jarrah")

    unilib.register_tree_sapling({
        -- From australia:jarrah_sapling. Creates unilib:tree_jarrah_sapling
        part_name = "jarrah",
        orig_name = "australia:jarrah_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Jarrah Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 10, y = 34, z = 10},
        minp_table = {x = -10, y = 1, z = -10},
        schem_list = {
            {"unilib_tree_jarrah_1", 8, 1, 8},
            {"unilib_tree_jarrah_2", 9, 1, 9},
            {"unilib_tree_jarrah_3", 10, 1, 0},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_jarrah_wood. Creates unilib:tree_jarrah_wood_fence
        part_name = "jarrah",
        orig_name = "australia:fence_jarrah_wood",

        replace_mode = mode,
        base_img = "unilib_tree_jarrah_wood.png",
        description = S("Jarrah Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_jarrah_wood_fence_rail
        part_name = "jarrah",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_jarrah_wood.png",
        description = S("Jarrah Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_jarrah_closed, etc
        part_name = "jarrah",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Jarrah Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_jarrah_in_forests_" .. i, {
            -- From australia/biome_jarrah_karri_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_jarrah_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 8000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
