---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_karri = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_karri.init()

    return {
        description = "Karri tree",
    }

end

function unilib.pkg.tree_karri.exec()

    local burnlevel = 3
    local sci_name = "Eucalyptus diversicolor"

    unilib.register_tree({
        -- Original to unilib
        part_name = "karri",
        description = S("Karri Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:karri_tree. Creates unilib:tree_karri_trunk
        part_name = "karri",
        orig_name = "australia:karri_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Karri Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:karri_wood. Creates unilib:tree_karri_wood
        part_name = "karri",
        orig_name = "australia:karri_wood",

        replace_mode = mode,
        description = S("Karri Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:karri_leaves. Creates unilib:tree_karri_leaves
        part_name = "karri",
        orig_name = "australia:karri_leaves",

        replace_mode = mode,
        description = S("Karri Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("karri")

    unilib.register_tree_sapling({
        -- From australia:karri_sapling. Creates unilib:tree_karri_sapling
        part_name = "karri",
        orig_name = "australia:karri_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Karri Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 12, y = 42, z = 12},
        minp_table = {x = -12, y = 1, z = -12},
        schem_list = {
            {"unilib_tree_karri_1", 10, 1, 10},
            {"unilib_tree_karri_2", 11, 1, 11},
            {"unilib_tree_karri_3", 12, 1, 12},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_karri_wood. Creates unilib:tree_karri_wood_fence
        part_name = "karri",
        orig_name = "australia:fence_karri_wood",

        replace_mode = mode,
        base_img = "unilib_tree_karri_wood.png",
        description = S("Karri Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_karri_wood_fence_rail
        part_name = "karri",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_karri_wood.png",
        description = S("Karri Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_karri_closed, etc
        part_name = "karri",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Karri Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_karri_in_forests_" .. i, {
            -- From australia/biome_jarrah_karri_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_karri_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
