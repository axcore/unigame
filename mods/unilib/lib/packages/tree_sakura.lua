---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_sakura = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_sakura.init()

    return {
        description = "Sakura tree",
        notes = "Two varieties, with pink and white leaves",
        optional = "dirt_ordinary_with_turf_bamboo",
    }

end

function unilib.pkg.tree_sakura.exec()

    local burnlevel = 3
    local sci_name = "Prunus serrulata"

    unilib.register_tree({
        -- Original to unilib
        part_name = "sakura",
        description = S("Sakura Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_sakura_trunk", "ethereal:sakura_trunk", mode, {
        -- From ethereal:sakura_trunk
        description = unilib.utils.annotate(S("Sakura Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_sakura_trunk_top.png",
            "unilib_tree_sakura_trunk_top.png",
            "unilib_tree_sakura_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- From ethereal:sakura_trunk. Creates unilib:tree_sakura_trunk_stripped
        part_name = "sakura",
        orig_name = "ethereal:sakura_trunk",

        replace_mode = mode,
        description = S("Sakura Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_sakura_wood", "ethereal:sakura_wood", mode, {
        -- From ethereal:sakura_wood
        description = S("Sakura Wood Planks"),
        tiles = {"unilib_tree_sakura_wood.png"},
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
        -- From ethereal:sakura_wood
        output = "unilib:tree_sakura_wood 4",
        recipe = {
            {"unilib:tree_sakura_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("sakura")

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_sakura_leaves.png")
    unilib.register_node("unilib:tree_sakura_leaves", "ethereal:sakura_leaves", mode, {
        -- From ethereal:sakura_leaves
        description = unilib.utils.annotate(S("Sakura Tree Leaves"), sci_name),
        tiles = {"unilib_tree_sakura_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_sakura_sapling"}, rarity = 30},
                {items = {"unilib:tree_sakura_leaves"}},
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
    unilib.register_tree_leaves_compacted("unilib:tree_sakura_leaves", mode)

    inv_img = unilib.flora.filter_leaves_img("unilib_tree_sakura_leaves_white.png")
    unilib.register_node("unilib:tree_sakura_leaves_white", "ethereal:sakura_leaves2", mode, {
        -- From ethereal:sakura_leaves2
        description = unilib.utils.annotate(S("White Sakura Tree Leaves"), sci_name),
        tiles = {"unilib_tree_sakura_leaves_white.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_sakura_sapling"}, rarity = 30},
                {items = {"unilib:tree_sakura_leaves_white"}},
            },
        },
        inventory_image = inv_img,
        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype = "light",
        -- N.B. no .paramtype2 in original code
        paramtype2 = "facedir",
        visual_scale = unilib.global.leaves_visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,
    })
    unilib.register_leafdecay({
        -- From ethereal:sakura_leaves
        trunk_type = "sakura",
        trunks = {"unilib:tree_sakura_trunk"},
        leaves = {"unilib:tree_sakura_leaves", "unilib:tree_sakura_leaves_white"},
        radius = 3,
    })
    unilib.register_tree_leaves_compacted("unilib:tree_sakura_leaves_white", mode)

    unilib.register_tree_sapling({
        -- From ethereal:sakura_sapling. Creates unilib:tree_sakura_sapling
        part_name = "sakura",
        orig_name = "ethereal:sakura_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Sakura Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 5, y = 10, z = 3},
        minp_table = {x = -5, y = 1, z = -3},
        offset_list = {4, 0, 3},
        paramtype2 = "facedir",
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_bamboo", "ethereal:bamboo_dirt"},

        replace_func = function(pos)

            if math.random(10) == 1 then
                return {["unilib:tree_sakura_leaves"] = "unilib:tree_sakura_leaves_white"}
            else
                return nil
            end

        end,
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_sakura. Creates unilib:tree_sakura_wood_fence
        part_name = "sakura",
        orig_name = "ethereal:fence_sakura",

        replace_mode = mode,
        base_img = "unilib_tree_sakura_wood.png",
        burnlevel = burnlevel,
        description = S("Sakura Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_sakura. Creates unilib:tree_sakura_wood_fence_rail
        part_name = "sakura",
        orig_name = "ethereal:fence_rail_sakura",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_sakura_wood.png",
        description = S("Sakura Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_sakura_closed, etc. Creates unilib:gate_sakura_closed, etc
        part_name = "sakura",
        orig_name = {"ethereal:fencegate_sakura_closed", "ethereal:fencegate_sakura_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Sakura Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_sakura", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_sakura.mts",

        fill_ratio = 0.002,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
