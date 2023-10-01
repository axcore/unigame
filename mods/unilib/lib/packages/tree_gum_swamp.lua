---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gum_swamp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gum_swamp.init()

    return {
        description = "Swamp gum tree",
    }

end

function unilib.pkg.tree_gum_swamp.exec()

    -- (no burnlevel)
    local sci_name = "Eucalyptus regnans"

    unilib.register_tree({
        -- Original to unilib
        part_name = "gum_swamp",
        description = S("Swamp Gum Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:swamp_gum_tree. Creates unilib:tree_gum_swamp_trunk
        part_name = "gum_swamp",
        orig_name = "australia:swamp_gum_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Swamp Gum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:swamp_gum_wood. Creates unilib:tree_gum_swamp_wood
        part_name = "gum_swamp",
        orig_name = "australia:swamp_gum_wood",

        replace_mode = mode,
        description = S("Swamp Gum Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:swamp_gum_leaves. Creates unilib:tree_gum_swamp_leaves
        part_name = "gum_swamp",
        orig_name = "australia:swamp_gum_leaves",

        replace_mode = mode,
        description = S("Swamp Gum Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("gum_swamp")

    unilib.register_tree_sapling({
        -- From australia:swamp_gum_sapling. Creates unilib:tree_gum_swamp_sapling
        part_name = "gum_swamp",
        orig_name = "australia:swamp_gum_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Swamp Gum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 6, y = 64, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        offset_list = {6, 1, 6},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_gum_swamp_wood. Creates unilib:tree_gum_swamp_wood_fence
        part_name = "gum_swamp",
        orig_name = "australia:fence_gum_swamp_wood",

        replace_mode = mode,
        base_img = "unilib_tree_gum_swamp_wood.png",
        description = S("Swamp Gum Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_gum_swamp_wood_fence_rail
        part_name = "gum_swamp",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_gum_swamp_wood.png",
        description = S("Swamp Gum Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_gum_swamp_closed
        part_name = "gum_swamp",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Swamp Gum Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    -- N.B. Tweaked these schematics to remove a rogue tree trunk node at the top
    unilib.register_decoration("australia_tree_gum_swamp_in_tasmania", {
        -- From australia/biome_tasmania.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_gum_swamp.mts",

        fill_ratio = 1 / 10000,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })
    unilib.register_decoration("australia_tree_gum_swamp_in_victoria", {
        -- From australia/biome_victorian_forests.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_gum_swamp.mts",

        fill_ratio = 1 / 15000,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
