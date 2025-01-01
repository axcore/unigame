---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak_river = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak_river.init()

    return {
        description = "River oak tree",
    }

end

function unilib.pkg.tree_oak_river.exec()

    local burnlevel = 3
    local sci_name = "Casuarina cunninghamiana"

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak_river",
        description = S("River Oak Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:river_oak_tree. Creates unilib:tree_oak_river_trunk
        part_name = "oak_river",
        orig_name = "australia:river_oak_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("River Oak Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:river_oak_wood. Creates unilib:tree_oak_river_wood
        part_name = "oak_river",
        orig_name = "australia:river_oak_wood",

        replace_mode = mode,
        description = S("River Oak Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:river_oak_leaves. Creates unilib:tree_oak_river_leaves
        part_name = "oak_river",
        orig_name = "australia:river_oak_leaves",

        replace_mode = mode,
        description = S("River Oak Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("oak_river")

    unilib.register_tree_sapling({
        -- From australia:river_oak_sapling. Creates unilib:tree_oak_river_sapling
        part_name = "oak_river",
        orig_name = "australia:river_oak_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("River Oak Tree Sapling"),
        max_volume = 4,
        -- N.B. Values from "large" schematic
        maxp_table = {x = 5, y = 23, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_oak_river_1", 3, 1, 3},
            {"unilib_tree_oak_river_2", 4, 1, 4},
            {"unilib_tree_oak_river_3", 4, 1, 4},
            {"unilib_tree_oak_river_4", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_oak_river_wood. Creates unilib:tree_oak_river_wood_fence
        part_name = "oak_river",
        orig_name = "australia:fence_oak_river_wood",

        replace_mode = mode,
        base_img = "unilib_tree_oak_river_wood.png",
        description = S("River Oak Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_oak_river_wood_fence_rail
        part_name = "oak_river",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_oak_river_wood.png",
        description = S("River Oak Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_oak_river_closed, etc
        part_name = "oak_river",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("River Oak Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_oak_river_in_arnhem_" .. i, {
            -- From australia/biome_arnhem_land.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_river_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_oak_river_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_river_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_oak_river_in_gulf_" .. i, {
            -- From australia/biome_gulf_of_carpentaria.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_river_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_oak_river_in_mulga_lands_" .. i, {
            -- From australia/biome_mulga_lands.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_river_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_oak_river_in_queensland_" .. i, {
            -- From australia/biome_far_north_queensland.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_oak_river_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 12000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
