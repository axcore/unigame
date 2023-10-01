---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gum_snow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gum_snow.init()

    return {
        description = "Snow gum tree",
        optional = "mushroom_brown",
    }

end

function unilib.pkg.tree_gum_snow.exec()

    -- (no burnlevel)
    local sci_name = "Eucalyptus pauciflora"

    unilib.register_tree({
        -- Original to unilib
        part_name = "gum_snow",
        description = S("Snow Gum Wood"),
    })

    unilib.register_tree_trunk({
        -- From australia:snow_gum_tree. Creates unilib:tree_gum_snow_trunk
        part_name = "gum_snow",
        orig_name = "australia:snow_gum_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Snow Gum Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From australia:snow_gum_wood. Creates unilib:tree_gum_snow_wood
        part_name = "gum_snow",
        orig_name = "australia:snow_gum_wood",

        replace_mode = mode,
        description = S("Snow Gum Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:snow_gum_leaves. Creates unilib:tree_gum_snow_leaves
        part_name = "gum_snow",
        orig_name = "australia:snow_gum_leaves",

        replace_mode = mode,
        description = S("Snow Gum Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("gum_snow")

    unilib.register_tree_sapling({
        -- From australia:snow_gum_sapling. Creates unilib:tree_gum_snow_sapling
        part_name = "gum_snow",
        orig_name = "australia:snow_gum_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Snow Gum Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 11, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_gum_snow_1", 3, 1, 3},
            {"unilib_tree_gum_snow_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_gum_snow_wood. Creates unilib:tree_gum_snow_wood_fence
        part_name = "gum_snow",
        orig_name = "australia:fence_gum_snow_wood",

        replace_mode = mode,
        base_img = "unilib_tree_gum_snow_wood.png",
        description = S("Snow Gum Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_gum_snow_wood_fence_rail
        part_name = "gum_snow",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_gum_snow_wood.png",
        description = S("Snow Gum Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_gum_snow_closed
        part_name = "gum_snow",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Snow Gum Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_gum_snow_in_alps_" .. i, {
            -- From australia/biome_australian_alps.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_gum_snow_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 2500,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["mushroom_brown"] ~= nil then

        unilib.register_decoration("australia_tree_gum_snow_log", {
            -- From australia/biome_australian_alps.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_gum_snow_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0018,
                persist = 0.66,
                scale = 0.0011,
                seed = 34,
                spread = {x = 250, y = 250, z = 250},
            },
            rotation = "random",
            sidelen = 16,
        })

    end

end
