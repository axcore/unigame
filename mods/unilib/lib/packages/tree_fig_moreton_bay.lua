---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fig_moreton_bay = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fig_moreton_bay.init()

    return {
        description = "Moreton Bay fig tree",
        notes = "Produces Moreton Bay figs",
        depends = "fruit_fig_moreton_bay",
    }

end

function unilib.pkg.tree_fig_moreton_bay.exec()

    -- (no burnlevel)
    local sci_name = "Ficus macrophylla"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fig_moreton_bay",
        description = S("Moreton Bay Fig Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:moreton_bay_fig_tree. Creates unilib:tree_fig_moreton_bay_trunk
        part_name = "fig_moreton_bay",
        orig_name = "australia:moreton_bay_fig_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Moreton Bay Fig Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:moreton_bay_fig_wood. Creates unilib:tree_fig_moreton_bay_wood
        part_name = "fig_moreton_bay",
        orig_name = "australia:moreton_bay_fig_wood",

        replace_mode = mode,
        description = S("Moreton Bay Fig Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:moreton_bay_fig_leaves. Creates unilib:tree_fig_moreton_bay_leaves
        part_name = "fig_moreton_bay",
        orig_name = "australia:moreton_bay_fig_leaves",

        replace_mode = mode,
        description = S("Moreton Bay Fig Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:moreton_bay_fig_leaves
        trunks = {"unilib:tree_fig_moreton_bay_trunk"},
        leaves = {"unilib:tree_fig_moreton_bay_leaves", "unilib:fruit_fig_moreton_bay"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:moreton_bay_fig_sapling. Creates unilib:tree_fig_moreton_bay_sapling
        part_name = "fig_moreton_bay",
        orig_name = "australia:moreton_bay_fig_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Moreton Bay Fig Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 13, y = 28, z = 13},
        minp_table = {x = -13, y = 1, z = -13},
        schem_list = {
            {"unilib_tree_fig_moreton_bay_1", 11, 1, 11},
            {"unilib_tree_fig_moreton_bay_2", 12, 1, 12},
            {"unilib_tree_fig_moreton_bay_3", 13, 1, 13},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_fig_moreton_bay_wood. Creates unilib:tree_fig_moreton_bay_wood_fence
        part_name = "fig_moreton_bay",
        orig_name = "australia:fence_fig_moreton_bay_wood",

        replace_mode = mode,
        base_img = "unilib_tree_fig_moreton_bay_wood.png",
        description = S("Moreton Bay Fig Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_fig_moreton_bay_wood_fence_rail
        part_name = "fig_moreton_bay",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_fig_moreton_bay_wood.png",
        description = S("Moreton Bay Fig Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_fig_moreton_bay_closed
        part_name = "fig_moreton_bay",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Moreton Bay Fig Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    for i = 1, 3 do

        unilib.register_decoration("australia_tree_fig_moreton_bay_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_fig_moreton_bay_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
