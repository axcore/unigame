---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_redwood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_redwood.init()

    return {
        description = "Redwood tree",
        notes = "Two different saplings produce normal and giant redwood trees",
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.tree_redwood.exec()

    local burnlevel = 3
    local sci_name = "Sequoia sempervirens"

    unilib.register_tree({
        -- Original to unilib
        part_name = "redwood",
        description = S("Redwood Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_redwood_trunk", "ethereal:redwood_trunk", mode, {
        -- From ethereal:redwood_trunk
        description = unilib.annotate(S("Redwood Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_redwood_trunk_top.png",
            "unilib_tree_redwood_trunk_top.png",
            "unilib_tree_redwood_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    if unilib.super_tree_table["redwood"] ~= nil then

        unilib.register_tree_trunk_stripped({
            -- From ethereal:redwood_trunk. Creates unilib:tree_redwood_trunk_stripped
            part_name = "redwood",
            orig_name = "ethereal:redwood_trunk",

            replace_mode = mode,
            description = S("Redwood Tree Trunk"),
            group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        })

    end

    unilib.register_node("unilib:tree_redwood_wood", "ethereal:redwood_wood", mode, {
        -- From ethereal:redwood_wood
        description = S("Redwood Wood Planks"),
        tiles = {"unilib_tree_redwood_wood.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From ethereal:redwood_wood
        output = "unilib:tree_redwood_wood 4",
        recipe = {
            {"unilib:tree_redwood_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("redwood")
    unilib.set_auto_rotate("unilib:tree_redwood_wood", unilib.auto_rotate_wood_flag)

    local inv_img = unilib.filter_leaves_img("unilib_tree_redwood_leaves.png")
    unilib.register_node("unilib:tree_redwood_leaves", "ethereal:redwood_leaves", mode, {
        -- From ethereal:redwood_leaves
        description = unilib.annotate(S("Redwood Tree Leaves"), sci_name),
        tiles = {"unilib_tree_redwood_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_redwood_sapling"}, rarity = 50},
                {items = {"unilib:tree_redwood_leaves"}}
            }
        },
        inventory_image = inv_img,
        paramtype = "light",
        visual_scale = unilib.leaves_visual_scale,
        walkable = unilib.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.after_place_leaves,
    })
    unilib.register_quick_tree_leafdecay("redwood")

    unilib.register_tree_sapling({
        -- From ethereal:redwood_sapling. Creates unilib:tree_redwood_normal_sapling
        part_name = "redwood_normal",
        orig_name = "ethereal:redwood_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Normal Redwood Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 21, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_dry", "default:dirt_with_dry_grass"},
    })

    unilib.register_tree_sapling({
        -- From ethereal:giant_redwood_sapling. Creates unilib:tree_redwood_giant_sapling
        part_name = "redwood_giant",
        orig_name = "ethereal:giant_redwood_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Giant Redwood Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 7, y = 33, z = 7},
        minp_table = {x = -7, y = 1, z = -7},
        offset_list = {7, 0, 7},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_dry", "default:dirt_with_dry_grass"},
    })
    unilib.register_craft({
        -- From ethereal:giant_redwood_sapling
        output = "unilib:tree_redwood_giant_sapling",
        recipe = {
            {"unilib:tree_redwood_normal_sapling", "unilib:tree_redwood_normal_sapling"},
        },
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_redwood. Creates unilib:tree_redwood_wood_fence
        part_name = "redwood",
        orig_name = "ethereal:fence_redwood",

        replace_mode = mode,
        base_img = "unilib_tree_redwood_wood.png",
        burnlevel = burnlevel,
        description = S("Redwood Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_redwood. Creates unilib:tree_redwood_wood_fence_rail
        part_name = "redwood",
        orig_name = "ethereal:fence_rail_redwood",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_redwood_wood.png",
        description = S("Redwood Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_redwood. Creates unilib:gate_redwood_closed
        part_name = "redwood",
        orig_name = {"ethereal:fencegate_redwood_closed", "ethereal:fencegate_redwood_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Redwood Wood Fence Gate"),
    })

    -- N.B. In original ethereal-ng code, there is no decoration for the giant redwood sapling
    unilib.register_decoration("ethereal_tree_redwood_normal", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_redwood_normal.mts",

        fill_ratio = 0.0025,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
