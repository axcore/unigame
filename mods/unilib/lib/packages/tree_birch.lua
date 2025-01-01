---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_birch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_birch.init()

    return {
        description = "Birch tree",
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.tree_birch.exec()

    local burnlevel = 3
    local sci_name = "Betula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "birch",
        description = S("Birch Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_birch_trunk", "ethereal:birch_trunk", mode, {
        -- From ethereal:birch_trunk
        description = unilib.utils.annotate(S("Birch Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_birch_trunk_top.png",
            "unilib_tree_birch_trunk_top.png",
            "unilib_tree_birch_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- From ethereal:birch_trunk. Creates unilib:tree_birch_trunk_stripped
        part_name = "birch",
        orig_name = "ethereal:birch_trunk",

        replace_mode = mode,
        description = S("Birch Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_birch_wood", "ethereal:birch_wood", mode, {
        -- From ethereal:birch_wood
        description = S("Birch Wood Planks"),
        tiles = {"unilib_tree_birch_wood.png"},
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
        -- From ethereal:birch_wood
        output = "unilib:tree_birch_wood 4",
        recipe = {
            {"unilib:tree_birch_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("birch")

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_birch_leaves.png")
    unilib.register_node("unilib:tree_birch_leaves", "ethereal:birch_leaves", mode, {
        -- From ethereal:birch_leaves
        description = unilib.utils.annotate(S("Birch Tree Leaves"), sci_name),
        tiles = {"unilib_tree_birch_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_birch_sapling"}, rarity = 20},
                {items = {"unilib:tree_birch_leaves"}},
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
    -- N.B. radius 3 in original code, but these leaves are re-used by the "tree_birch_large"
    --      package, which requires a radius of 5
    unilib.register_quick_tree_leafdecay("birch", 5)
    unilib.register_tree_leaves_compacted("unilib:tree_birch_leaves", mode)

    unilib.register_tree_sapling({
        -- From ethereal:birch_sapling. Creates unilib:tree_birch_sapling
        part_name = "birch",
        orig_name = "ethereal:birch_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Birch Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 2, y = 7, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf", "default:dirt_with_grass"},
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_birch. Creates unilib:tree_birch_wood_fence
        part_name = "birch",
        orig_name = "ethereal:fence_birch",

        replace_mode = mode,
        base_img = "unilib_tree_birch_wood.png",
        burnlevel = burnlevel,
        description = S("Birch Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_birch. Creates unilib:tree_birch_wood_fence_rail
        part_name = "birch",
        orig_name = "ethereal:fence_rail_birch",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_birch_wood.png",
        description = S("Birch Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_birch_closed, etc. Creates unilib:gate_birch_closed, etc
        part_name = "birch",
        orig_name = {"ethereal:fencegate_birch_closed", "ethereal:fencegate_birch_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Birch Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_birch", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_birch.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
