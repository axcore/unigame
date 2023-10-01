---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_lemon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_lemon.init()

    return {
        description = "Lemon tree",
        notes = "Produces lemons",
        depends = "fruit_lemon",
        optional = "dirt_ordinary_with_turf_grove",
    }

end

function unilib.pkg.tree_lemon.exec()

    local burnlevel = 3
    local sci_name = "Citrus limon"

    unilib.register_tree({
        -- Original to unilib
        part_name = "lemon",
        description = S("Lemon Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- Original to unilib
        part_name = "lemon",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Lemon Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- Original to unilib
        part_name = "lemon",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Lemon Tree Wood Planks"),
    })

    local inv_img = unilib.filter_leaves_img("unilib_tree_lemon_leaves.png")
    unilib.register_node("unilib:tree_lemon_leaves", "ethereal:lemon_leaves", mode, {
        -- From ethereal:lemon_leaves
        description = unilib.annotate(S("Lemon Tree Leaves"), sci_name),
        tiles = {"unilib_tree_lemon_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_lemon_sapling"}, rarity = 25},
                {items = {"unilib:tree_lemon_leaves"}},
            },
        },
        inventory_image = inv_img,
        paramtype = "light",
        visual_scale = unilib.leaves_visual_scale,
        walkable = unilib.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.after_place_leaves,
    })
    unilib.register_leafdecay({
        -- From ethereal:lemon_leaves
        trunks = {"unilib:tree_lemon_trunk"},
        leaves = {"unilib:tree_lemon_leaves", "unilib:fruit_lemon"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From ethereal:lemon_tree_sapling. Creates unilib:tree_lemon_sapling
        part_name = "lemon",
        orig_name = "ethereal:lemon_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Lemon Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 2, y = 8, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_grove", "ethereal:grove_dirt"},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "lemon",

        replace_mode = mode,
        burnlevel = burnlevel,
        fence_description = S("Lemon Tree Wood Fence"),
        gate_description = S("Lemon Tree Wood Fence Rail"),
        rail_description = S("Lemon Tree Wood Fence Gate"),
    })

    unilib.register_decoration("ethereal_tree_lemon", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_lemon.mts",

        fill_ratio = 0.002,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
