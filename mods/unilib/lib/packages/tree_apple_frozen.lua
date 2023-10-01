---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_apple_frozen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_apple_frozen.init()

    return {
        description = "Frozen apple tree nodes",
        notes = "A special apple tree whose leaves drop both normal and frozen apple tree" ..
                " saplings. Produces frozen apple tree apples",
        depends = {"fruit_apple_frozen", "tree_apple"},
    }

end

function unilib.pkg.tree_apple_frozen.exec()

    -- (Schematic uses trunk and wood nodes from the default apple tree)

    -- (no burnlevel)
    local sci_name = "Malus sieversii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "apple_frozen",
        -- N.B. Not "Frozen Apple Tree Wood", obviously
        description = S("Apple Tree Wood"),

        not_super_flag = true,
    })

    local inv_img = unilib.filter_leaves_img("unilib_tree_apple_leaves_frozen.png")
    unilib.register_node("unilib:tree_apple_frozen_leaves", "snow:leaves", mode, {
        -- From snow:leaves
        description = unilib.annotate(S("Frozen Apple Tree Leaves"), sci_name),
        tiles = {"unilib_tree_apple_leaves_frozen.png"},
        groups = {flammable = 1, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_apple_sapling"}, rarity = 20},
                {items = {"unilib:tree_apple_frozen_sapling"}, rarity = 20},
                {items = {"unilib:tree_apple_frozen_leaves"}},
            },
        },
        inventory_image = inv_img,
        paramtype = "light",
        visual_scale = unilib.leaves_visual_scale,
        -- N.B. walkable not in original code
        walkable = true,
        waving = 1,
        wield_img = inv_img,
    })
    unilib.register_leafdecay({
        -- From snow:leaves
        trunks = {"unilib:tree_apple_trunk"},
        leaves = {
            "unilib:fruit_apple",
            "unilib:fruit_apple_frozen",
            "unilib:tree_apple_leaves",
            "unilib:tree_apple_frozen_leaves",
        },
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- Original to unilib, adapted from minetest_game's default tree
        part_name = "apple_frozen",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Frozen Apple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        offset_list = {3, 1, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_decoration("snow_tree_apple_frozen", {
        -- Original to unilib, adapted from minetest_game's default tree
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_apple_frozen.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.024,
            persist = 0.66,
            scale = 0.015,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
