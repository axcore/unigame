---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_sassafras_southern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_sassafras_southern.init()

    return {
        description = "Southern sassafras tree",
    }

end

function unilib.pkg.tree_sassafras_southern.exec()

    -- (no burnlevel)
    local sci_name = "Atherosperma moschatum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "sassafras_southern",
        description = S("Southern Sassafras Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:southern_sassafras_tree. Creates unilib:tree_sassafras_southern_trunk
        part_name = "sassafras_southern",
        orig_name = "australia:southern_sassafras_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Southern Sassafras Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:southern_sassafras_wood. Creates unilib:tree_sassafras_southern_wood
        part_name = "sassafras_southern",
        orig_name = "australia:southern_sassafras_wood",

        replace_mode = mode,
        description = S("Southern Sassafras Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:southern_sassafras_leaves. Creates unilib:tree_sassafras_southern_leaves
        part_name = "sassafras_southern",
        orig_name = "australia:southern_sassafras_leaves",

        replace_mode = mode,
        description = S("Southern Sassafras Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("sassafras_southern")

    unilib.register_tree_sapling({
        -- From australia:southern_sassafras_sapling. Creates unilib:tree_sassafras_southern_sapling
        part_name = "sassafras_southern",
        orig_name = "australia:southern_sassafras_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Southern Sassafras Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 20, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_sassafras_southern_1", 4, 1, 4},
            {"unilib_tree_sassafras_southern_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_sassafras_southern_wood. Creates
        --      unilib:tree_sassafras_southern_wood_fence
        part_name = "sassafras_southern",
        orig_name = "australia:fence_sassafras_southern_wood",

        replace_mode = mode,
        base_img = "unilib_tree_sassafras_southern_wood.png",
        description = S("Southern Sassafras Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_sassafras_southern_wood_fence_rail
        part_name = "sassafras_southern",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_sassafras_southern_wood.png",
        description = S("Southern Sassafras Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_sassafras_southern_closed
        part_name = "sassafras_southern",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Southern Sassafras Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_sassafras_southern_in_range_" .. i, {
            -- From australia/biome_great_dividing_range.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_sassafras_southern_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_sassafras_southern_in_tasmania_" .. i, {
            -- From australia/biome_tasmania.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_sassafras_southern_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 8000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration("australia_tree_sassafras_southern_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_sassafras_southern_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
