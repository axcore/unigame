---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_willow_weeping = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_willow_weeping.init()

    return {
        description = "Weeping Willow tree",
        optional = "dirt_ordinary_with_turf_grey",
    }

end

function unilib.pkg.tree_willow_weeping.exec()

    local burnlevel = 3
    local sci_name = "Salix babylonica"

    unilib.register_tree({
        -- Original to unilib
        part_name = "willow_weeping",
        description = S("Weeping Willow Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_willow_weeping_trunk", "ethereal:willow_trunk", mode, {
        -- From ethereal:willow_trunk
        description = unilib.utils.annotate(S("Weeping Willow Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_willow_weeping_trunk_top.png",
            "unilib_tree_willow_weeping_trunk_top.png",
            "unilib_tree_willow_weeping_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- From ethereal:willow_trunk. Creates unilib:tree_willow_weeping_trunk_stripped
        part_name = "willow_weeping",
        orig_name = "ethereal:willow_trunk",

        replace_mode = mode,
        description = S("Weeping Willow Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_willow_weeping_wood", "ethereal:willow_wood", mode, {
        -- From ethereal:willow_wood
        description = S("Weeping Willow Wood Planks"),
        tiles = {"unilib_tree_willow_weeping_wood.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        -- N.B. no .place_param2 in original code
        place_param2 = place_param2,

        -- N.B. no .on_place in original code
        on_place = on_place,
    })
    unilib.register_craft({
        -- From ethereal:willow_wood
        output = "unilib:tree_willow_weeping_wood 4",
        recipe = {
            {"unilib:tree_willow_weeping_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("willow_weeping")

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_willow_weeping_leaves.png")
    unilib.register_node("unilib:tree_willow_weeping_leaves", "ethereal:willow_twig", mode, {
        -- From ethereal:willow_twig
        description = unilib.utils.annotate(S("Weeping Willow Tree Twig"), sci_name),
        tiles = {"unilib_tree_willow_weeping_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_willow_weeping_sapling"}, rarity = 50},
                {items = {"unilib:tree_willow_weeping_leaves"}},
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
    unilib.register_quick_tree_leafdecay("willow_weeping")
    unilib.register_tree_leaves_compacted("unilib:tree_willow_weeping_leaves", mode)

    unilib.register_tree_sapling({
        -- From ethereal:willow_sapling. Creates unilib:tree_willow_weeping_sapling
        part_name = "willow_weeping",
        orig_name = "ethereal:willow_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Weeping Willow Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 6, y = 14, z = 6},
        minp_table = {x = -6, y = 1, z = -6},
        offset_list = {5, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_grey", "ethereal:gray_dirt"},
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_willow. Creates unilib:tree_willow_weeping_wood_fence
        part_name = "willow_weeping",
        orig_name = "ethereal:fence_willow",

        replace_mode = mode,
        base_img = "unilib_tree_willow_weeping_wood.png",
        burnlevel = burnlevel,
        description = S("Weeping Willow Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_willow. Creates unilib:tree_willow_weeping_wood_fence_rail
        part_name = "willow_weeping",
        orig_name = "ethereal:fence_rail_willow",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_willow_weeping_wood.png",
        description = S("Weeping Willow Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_willow_closed, etc. Creates unilib:gate_willow_weeping_closed,
        --      etc
        part_name = "willow_weeping",
        orig_name = {"ethereal:fencegate_willow_closed", "ethereal:fencegate_willow_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Weeping Willow Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_willow_weeping", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_willow_weeping.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
