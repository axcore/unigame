---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_myrtle_tasmanian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_myrtle_tasmanian.init()

    return {
        description = "Tasmanian myrtle tree",
    }

end

function unilib.pkg.tree_myrtle_tasmanian.exec()

    local burnlevel = 3
    local sci_name = "Lophozonia cunninghamii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "myrtle_tasmanian",
        description = S("Tasmanian Myrtle Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:tasmanian_myrtle_tree. Creates unilib:tree_myrtle_tasmanian_trunk
        part_name = "myrtle_tasmanian",
        orig_name = "australia:tasmanian_myrtle_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Tasmanian Myrtle Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:tasmanian_myrtle_wood. Creates unilib:tree_myrtle_tasmanian_wood
        part_name = "myrtle_tasmanian",
        orig_name = "australia:tasmanian_myrtle_wood",

        replace_mode = mode,
        description = S("Tasmanian Myrtle Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:tasmanian_myrtle_leaves. Creates unilib:tree_myrtle_tasmanian_leaves
        part_name = "myrtle_tasmanian",
        orig_name = "australia:tasmanian_myrtle_leaves",

        replace_mode = mode,
        description = S("Tasmanian Myrtle Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("myrtle_tasmanian")

    unilib.register_tree_sapling({
        -- From australia:tasmanian_myrtle_sapling. Creates unilib:tree_myrtle_tasmanian_sapling
        part_name = "myrtle_tasmanian",
        orig_name = "australia:tasmanian_myrtle_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Tasmanian Myrtle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 36, z = 8},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_tree_myrtle_tasmanian_1", 6, 1, 6},
            {"unilib_tree_myrtle_tasmanian_2", 7, 1, 7},
            {"unilib_tree_myrtle_tasmanian_3", 8, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_myrtle_tasmanian_wood. Creates
        --      unilib:tree_myrtle_tasmanian_wood_fence
        part_name = "myrtle_tasmanian",
        orig_name = "australia:fence_myrtle_tasmanian_wood",

        replace_mode = mode,
        base_img = "unilib_tree_myrtle_tasmanian_wood.png",
        description = S("Tasmanian Myrtle Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_myrtle_tasmanian_wood_fence_rail
        part_name = "myrtle_tasmanian",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_myrtle_tasmanian_wood.png",
        description = S("Tasmanian Myrtle Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_myrtle_tasmanian_closed, etc
        part_name = "myrtle_tasmanian",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Tasmanian Myrtle Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_myrtle_tasmanian_in_tasmania_" .. i, {
            -- From australia/biome_tasmania.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_myrtle_tasmanian_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 3 do

        unilib.register_decoration_generic("australia_tree_myrtle_tasmanian_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_myrtle_tasmanian_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
