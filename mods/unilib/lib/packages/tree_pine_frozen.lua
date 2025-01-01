---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_frozen.init()

    return {
        description = "Frozen pine tree nodes",
        notes = "A special pine tree whose leaves drop Christmas tree saplings (if that" ..
                " package is loaded)",
        depends = {"snow_ordinary", "tree_pine"},
    }

end

function unilib.pkg.tree_pine_frozen.exec()

    -- (Schematic uses trunk and wood nodes from the default pine tree)

    -- (no burnlevel)
    local sci_name = "Pinus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_frozen",
        -- N.B. Not "Frozen Pine Wood", obviously
        description = S("Pine Wood"),

        not_super_flag = true,
    })

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_pine_frozen_leaves.png")
    unilib.register_node("unilib:tree_pine_frozen_leaves", "snow:needles", mode, {
        -- From snow:needles
        description = unilib.utils.annotate(S("Frozen Pine Tree Needles"), sci_name),
        tiles = {"unilib_tree_pine_frozen_leaves.png"},
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_pine_frozen_sapling"}, rarity = 20},
                {items = {"unilib:tree_pine_frozen_leaves"}},
            },
        },
        furnace_burntime = 1,
        inventory_image = inv_img,
        -- N.B. is_ground_content = false not in original code; added to match other leaves
        is_ground_content = false,
        paramtype = "light",
        visual_scale = unilib.global.leaves_visual_scale,
        -- N.B. walkable not in original code
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,
    })
    -- N.B. .register_leafdecay() is called in the .post() function
    unilib.register_tree_leaves_compacted("unilib:tree_pine_frozen_leaves", mode)

    unilib.register_tree_sapling({
        -- Code original to unilib, texture from snow mod
        part_name = "pine_frozen",
        orig_name = "snow:sapling_pine",

        replace_mode = mode,
        common_group = 3,
        description = S("Frozen Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 1, y = 8, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        offset_list = {1, 1, 1},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_decoration_generic("snow_tree_pine_frozen_1", {
        -- From snow/mapgen_v7.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_frozen.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        sidelen = 16,
    })

    unilib.register_decoration_generic("snow_tree_pine_frozen_2", {
        -- From snow/mapgen_v7.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_frozen.mts",

        fill_ratio = 0.05,
        flags = "place_center_x, place_center_z",
        sidelen = 16,
    })

    unilib.register_decoration_generic("snow_tree_pine_frozen_3", {
        -- From snow/mapgen_v7.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_pine_frozen.mts",

        fill_ratio = 0.1,
        flags = "place_center_x, place_center_z",
        sidelen = 16,
    })

end

function unilib.pkg.tree_pine_frozen.post()

    -- N.B. We would like to make "tree_pine_christmas" an optional dependency of this package, but
    --      it already depends on this package. Instead, put the leaf decay/drop code here
    if unilib.global.pkg_executed_table["tree_pine_christmas"] == nil then

        unilib.register_leafdecay({
            -- From snow:needles
            trunk_type = "pine",
            trunks = {"unilib:tree_pine_trunk"},
            leaves = {
                "unilib:tree_pine_leaves",
                "unilib:tree_pine_frozen_leaves",
            },
            -- N.B. 2 in original "snow" mod code
            radius = 3,
        })

    else

        unilib.override_item("unilib:tree_pine_frozen_leaves", {
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_pine_frozen_sapling"}, rarity = 20},
                    {items = {"unilib:tree_pine_christmas_sapling"}, rarity = 120},
                    {items = {"unilib:tree_pine_frozen_leaves"}},
                },
            },
        })

        unilib.register_leafdecay({
            -- From snow:needles
            trunk_type = "pine",
            trunks = {"unilib:tree_pine_trunk"},
            leaves = {
                "unilib:tree_pine_leaves",
                "unilib:tree_pine_christmas_leaves",
                "unilib:tree_pine_frozen_leaves",
            },
            -- N.B. 2 in original "snow" mod code
            radius = 3,
        })

    end

end
