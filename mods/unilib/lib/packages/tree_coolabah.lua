---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_coolabah = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_coolabah.init()

    return {
        description = "Coolabah tree",
    }

end

function unilib.pkg.tree_coolabah.exec()

    local burnlevel = 3
    local sci_name = "Eucalyptus coolabah"

    unilib.register_tree({
        -- Original to unilib
        part_name = "coolabah",
        description = S("Coolabah Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:coolabah_tree. Creates unilib:tree_coolabah_trunk
        part_name = "coolabah",
        orig_name = "australia:coolabah_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Coolabah Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:coolabah_wood. Creates unilib:tree_coolabah_wood
        part_name = "coolabah",
        orig_name = "australia:coolabah_wood",

        replace_mode = mode,
        description = S("Coolabah Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:coolabah_leaves. Creates unilib:tree_coolabah_leaves
        part_name = "coolabah",
        orig_name = "australia:coolabah_leaves",

        replace_mode = mode,
        description = S("Coolabah Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("coolabah")

    unilib.register_tree_sapling({
        -- From australia:coolabah_sapling. Creates unilib:tree_coolabah_sapling
        part_name = "coolabah",
        orig_name = "australia:coolabah_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Coolabah Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 19, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_coolabah_1", 4, 1, 4},
            {"unilib_tree_coolabah_2", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_coolabah_wood. Creates unilib:tree_coolabah_wood_fence
        part_name = "coolabah",
        orig_name = "australia:fence_coolabah_wood",

        replace_mode = mode,
        base_img = "unilib_tree_coolabah_wood.png",
        description = S("Coolabah Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_coolabah_wood_fence_rail
        part_name = "coolabah",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_coolabah_wood.png",
        description = S("Coolabah Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_coolabah_closed, etc
        part_name = "coolabah",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Coolabah Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_central_" .. i, {
            -- From australia/biome_central_australia.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_eastern_" .. i, {
            -- From australia/biome_eastern_coasts.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_flinders_" .. i, {
            -- From australia/biome_flinders_lofty.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 15000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_forests_" .. i, {
            -- From australia/biome_jarrah_karri_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_mulga_lands_" .. i, {
            -- From australia/biome_mulga_lands.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_murray_" .. i, {
            -- From australia/biome_murray_darling_basin.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_simpson_" .. i, {
            -- From australia/biome_simpson_desert.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end
    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_coolabah_in_victoria_" .. i, {
            -- From australia/biome_victorian_forests.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_coolabah_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 20000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
