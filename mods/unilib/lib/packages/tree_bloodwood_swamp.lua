---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_bloodwood_swamp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_bloodwood_swamp.init()

    return {
        description = "Swamp bloodwood tree",
    }

end

function unilib.pkg.tree_bloodwood_swamp.exec()

    local burnlevel = 2
    local sci_name = "Corymbia ptychocarpa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "bloodwood_swamp",
        description = S("Swamp Bloodwood Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:swamp_bloodwood_tree. Creates unilib:tree_bloodwood_swamp_trunk
        part_name = "bloodwood_swamp",
        orig_name = "australia:swamp_bloodwood_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Swamp Bloodwood Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:swamp_bloodwood_wood. Creates unilib:tree_bloodwood_swamp_wood
        part_name = "bloodwood_swamp",
        orig_name = "australia:swamp_bloodwood_wood",

        replace_mode = mode,
        description = S("Swamp Bloodwood Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:swamp_bloodwood_leaves. Creates unilib:tree_bloodwood_swamp_leaves
        part_name = "bloodwood_swamp",
        orig_name = "australia:swamp_bloodwood_leaves",

        replace_mode = mode,
        description = S("Swamp Bloodwood Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("bloodwood_swamp")

    unilib.register_tree_sapling({
        -- From australia:swamp_bloodwood_sapling. Creates unilib:tree_bloodwood_swamp_sapling
        part_name = "bloodwood_swamp",
        orig_name = "australia:swamp_bloodwood_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Swamp Bloodwood Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 17, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_bloodwood_swamp_1", 3, 1, 3},
            {"unilib_tree_bloodwood_swamp_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_bloodwood_swamp_wood. Creates unilib:tree_bloodwood_swamp_wood_fence
        part_name = "bloodwood_swamp",
        orig_name = "australia:fence_bloodwood_swamp_wood",

        replace_mode = mode,
        base_img = "unilib_tree_bloodwood_swamp_wood.png",
        description = S("Swamp Bloodwood Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_bloodwood_swamp_wood_fence_rail
        part_name = "bloodwood_swamp",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_bloodwood_swamp_wood.png",
        description = S("Swamp Bloodwood Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_bloodwood_swamp_closed, etc
        part_name = "bloodwood_swamp",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Swamp Bloodwood Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_bloodwood_swamp_in_kimberley_" .. i, {
            -- From australia/biome_kimberley.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_bloodwood_swamp_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
