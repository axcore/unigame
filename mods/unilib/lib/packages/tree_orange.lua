---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_orange.init()

    return {
        description = "Orange tree",
        notes = "Produces oranges",
        depends = "fruit_orange",
        optional = "dirt_ordinary_with_turf_prairie",
    }

end

function unilib.pkg.tree_orange.exec()

    local burnlevel = 3
    local sci_name = "Citrus sinensis"

    unilib.register_tree({
        -- Original to unilib
        part_name = "orange",
        description = S("Orange Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- Textures from GLEMr4, lib_ecology_tree_orange_trunk_top.png and
        --      lib_ecology_tree_orange_trunk.png. Original code
        part_name = "orange",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Orange Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- Texture from GLEMr4, lib_ecology_tree_orange_wood.png. Original code
        part_name = "orange",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Orange Tree Wood Planks"),
    })

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_orange_leaves.png")
    unilib.register_node("unilib:tree_orange_leaves", "ethereal:orange_leaves", mode, {
        -- From ethereal:orange_leaves
        description = unilib.utils.annotate(S("Orange Tree Leaves"), sci_name),
        tiles = {"unilib_tree_orange_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_orange_sapling"}, rarity = 15},
                {items = {"unilib:tree_orange_leaves"}},
            },
        },
        inventory_image = inv_img,
        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype = "light",
        visual_scale = unilib.global.leaves_visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,
    })
    unilib.register_leafdecay({
        -- From ethereal:orange_leaves
        trunk_type = "orange",
        trunks = {"unilib:tree_orange_trunk"},
        leaves = {"unilib:tree_orange_leaves"},
        others = {"unilib:fruit_orange"},
        radius = 3,
    })
    unilib.register_tree_leaves_compacted("unilib:tree_orange_leaves", mode)

    unilib.register_tree_sapling({
        -- From ethereal:orange_tree_sapling. Creates unilib:tree_orange_sapling
        part_name = "orange",
        orig_name = "ethereal:orange_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Orange Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_prairie", "ethereal:prairie_dirt"},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "orange",

        replace_mode = mode,
        burnlevel = burnlevel,
        fence_description = S("Orange Tree Wood Fence"),
        gate_description = S("Orange Tree Wood Fence Rail"),
        rail_description = S("Orange Tree Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_orange", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_orange.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
