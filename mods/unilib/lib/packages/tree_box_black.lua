---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_box_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_box_black.init()

    return {
        description = "Black box tree",
    }

end

function unilib.pkg.tree_box_black.exec()

    -- (no burnlevel)
    local sci_name = "Eucalyptus largiflorens"

    unilib.register_tree({
        -- Original to unilib
        part_name = "box_black",
        description = S("Black Box Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:black_box_tree. Creates unilib:tree_box_black_trunk
        part_name = "box_black",
        orig_name = "australia:black_box_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Black Box Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:black_box_wood. Creates unilib:tree_box_black_wood
        part_name = "box_black",
        orig_name = "australia:black_box_wood",

        replace_mode = mode,
        description = S("Black Box Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:black_box_leaves. Creates unilib:tree_box_black_leaves
        part_name = "box_black",
        orig_name = "australia:black_box_leaves",

        replace_mode = mode,
        description = S("Black Box Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("box_black")

    unilib.register_tree_sapling({
        -- From australia:black_box_sapling. Creates unilib:tree_box_black_sapling
        part_name = "box_black",
        orig_name = "australia:black_box_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Black Box Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 8, y = 22, z = 8},
        minp_table = {x = -8, y = 1, z = -8},
        schem_list = {
            {"unilib_tree_box_black_1", 6, 1, 6},
            {"unilib_tree_box_black_2", 7, 1, 7},
            {"unilib_tree_box_black_3", 8, 1, 8},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_black_box_wood. Creates unilib:tree_box_black_wood_fence
        part_name = "box_black",
        orig_name = "australia:fence_box_black_wood",

        replace_mode = mode,
        base_img = "unilib_tree_box_black_wood.png",
        description = S("Black Box Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_box_black_wood_fence_rail
        part_name = "box_black",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_box_black_wood.png",
        description = S("Black Box Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_box_black_closed
        part_name = "box_black",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Black Box Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 3 do

        unilib.register_decoration("australia_tree_box_black_in_murray_" .. i, {
            -- From australia/biome_murray_darling_basin.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_box_black_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
