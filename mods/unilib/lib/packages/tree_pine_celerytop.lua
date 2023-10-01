---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_celerytop = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_celerytop.init()

    return {
        description = "Celerytop pine tree",
    }

end

function unilib.pkg.tree_pine_celerytop.exec()

    -- (no burnlevel)
    local sci_name = "Phyllocladus aspleniifolius"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_celerytop",
        description = S("Celerytop Pine Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:celery_top_pine_tree. Creates unilib:tree_pine_celerytop_trunk
        part_name = "pine_celerytop",
        orig_name = "australia:celery_top_pine_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Celerytop Pine Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:celery_top_pine_wood. Creates unilib:tree_pine_celerytop_wood
        part_name = "pine_celerytop",
        orig_name = "australia:celery_top_pine_wood",

        replace_mode = mode,
        description = S("Celerytop Pine Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:celery_top_pine_leaves. Creates unilib:tree_pine_celerytop_leaves
        part_name = "pine_celerytop",
        orig_name = "australia:celery_top_pine_leaves",

        replace_mode = mode,
        description = S("Celerytop Pine Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("pine_celerytop")

    unilib.register_tree_sapling({
        -- From australia:celery_top_pine_sapling. Creates unilib:tree_pine_celerytop_sapling
        part_name = "pine_celerytop",
        orig_name = "australia:celery_top_pine_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Celerytop Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 19, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_pine_celerytop_1", 4, 1, 4},
            {"unilib_tree_pine_celerytop_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_pine_celerytop_wood. Creates unilib:tree_pine_celerytop_wood_fence
        part_name = "pine_celerytop",
        orig_name = "australia:fence_pine_celerytop_wood",

        replace_mode = mode,
        base_img = "unilib_tree_pine_celerytop_wood.png",
        description = S("Celerytop Pine Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pine_celerytop_wood_fence_rail
        part_name = "pine_celerytop",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pine_celerytop_wood.png",
        description = S("Celerytop Pine Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_pine_celerytop_closed
        part_name = "pine_celerytop",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Celerytop Pine Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_pine_celerytop_in_tasmania_" .. i, {
            -- From australia/biome_tasmania.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_celerytop_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 8000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
