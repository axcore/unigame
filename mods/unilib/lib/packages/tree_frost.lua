---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_frost = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_frost.init()

    return {
        description = "Frost tree",
        optional = "dirt_ordinary_with_turf_crystal",
    }

end

function unilib.pkg.tree_frost.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "frost",
        description = S("Frost Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_frost_trunk", "ethereal:frost_tree", mode, {
        -- From ethereal:frost_tree
        description = S("Frost Tree Trunk"),
        tiles = {
            "unilib_tree_frost_trunk_top.png",
            "unilib_tree_frost_trunk_top.png",
            "unilib_tree_frost_trunk.png",
        },
        groups = {choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- From ethereal:frost_tree. Creates unilib:tree_frost_trunk_stripped
        part_name = "frost",
        orig_name = "ethereal:frost_tree",

        replace_mode = mode,
        description = S("Frost Tree Trunk"),
        group_table = {choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1, tree = 1},
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_frost_wood", "ethereal:frost_wood", mode, {
        -- From ethereal:frost_wood
        description = S("Frost Tree Wood Planks"),
        tiles = {"unilib_tree_frost_wood.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        -- N.B. no .place_param2 in original code
        place_param2 = place_param2,

        -- N.B. no .on_place in original code
        on_place = on_place,
    })
    unilib.register_craft({
        -- From ethereal:frost_wood
        output = "unilib:tree_frost_wood 4",
        recipe = {
            {"unilib:tree_frost_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("frost")

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_frost_leaves.png")
    unilib.register_node("unilib:tree_frost_leaves", "ethereal:frost_leaves", mode, {
        -- From ethereal:frost_leaves
        description = S("Frost Tree Leaves"),
        tiles = {"unilib_tree_frost_leaves.png"},
        groups = {leafdecay = 3, leaves = 1, puts_out_fire = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_frost_sapling"}, rarity = 15},
                {items = {"unilib:tree_frost_leaves"}},
            },
        },
        inventory_image = inv_img,
        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        light_source = 9,
        paramtype = "light",
        visual_scale = unilib.global.leaves_visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,
    })
    unilib.register_quick_tree_leafdecay("frost")
    unilib.register_tree_leaves_compacted("unilib:tree_frost_leaves", mode)

    unilib.register_tree_sapling({
        -- From ethereal:frost_tree_sapling. Creates unilib:tree_frost_sapling
        part_name = "frost",
        orig_name = "ethereal:frost_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Frost Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 19, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_crystal", "ethereal:crystal_dirt"},
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_frostwood. Creates unilib:tree_frost_wood_fence
        part_name = "frost",
        orig_name = "ethereal:fence_frostwood",

        replace_mode = mode,
        base_img = "unilib_tree_frost_wood.png",
        burnlevel = burnlevel,
        description = S("Frost Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_frostwood. Creates unilib:tree_frost_wood_fence_rail
        part_name = "frost",
        orig_name = "ethereal:fence_rail_frostwood",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_frost_wood.png",
        description = S("Frost Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_frostwood_closed, etc. Creates unilib:gate_frost_closed, etc
        part_name = "frost",
        orig_name = {"ethereal:fencegate_frostwood_closed", "ethereal:fencegate_frostwood_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Frost Tree Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_frost", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_frost.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
