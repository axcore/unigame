---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_boab = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_boab.init()

    return {
        description = "Boab tree",
    }

end

function unilib.pkg.tree_boab.exec()

    local burnlevel = 2
    local sci_name = "Adansonia gregorii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "boab",
        description = S("Boab Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:boab_tree. Creates unilib:tree_boab_trunk
        part_name = "boab",
        orig_name = "australia:boab_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Boab Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:boab_wood. Creates unilib:tree_boab_wood
        part_name = "boab",
        orig_name = "australia:boab_wood",

        replace_mode = mode,
        description = S("Boab Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:boab_leaves. Creates unilib:tree_boab_leaves
        part_name = "boab",
        orig_name = "australia:boab_leaves",

        replace_mode = mode,
        description = S("Boab Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("boab")

    unilib.register_tree_sapling({
        -- From australia:boab_sapling. Creates unilib:tree_boab_sapling
        part_name = "boab",
        orig_name = "australia:boab_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Boab Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 13, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_boab_1", 3, 1, 3},
            {"unilib_tree_boab_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_boab_wood. Creates unilib:tree_boab_wood_fence
        part_name = "boab",
        orig_name = "australia:fence_boab_wood",

        replace_mode = mode,
        base_img = "unilib_tree_boab_wood.png",
        description = S("Boab Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_boab_wood_fence_rail
        part_name = "boab",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_boab_wood.png",
        description = S("Boab Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_boab_closed, etc
        part_name = "boab",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Boab Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_boab_in_kimberley_" .. i, {
            -- From australia/biome_kimberley.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_boab_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
