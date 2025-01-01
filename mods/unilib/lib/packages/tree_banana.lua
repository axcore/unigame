---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_banana.init()

    return {
        description = "Banana tree",
        notes = "Produces bananas. One in three trees produces bananas in bunches",
        depends = "fruit_banana",
        optional = "dirt_ordinary_with_turf_grove",
    }

end

function unilib.pkg.tree_banana.exec()

    local burnlevel = 3
    local sci_name = "Musa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "banana",
        description = S("Banana Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_banana_trunk", "ethereal:banana_trunk", mode, {
        -- From ethereal:banana_trunk
        description = unilib.utils.annotate(S("Banana Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_banana_trunk_top.png",
            "unilib_tree_banana_trunk_top.png",
            "unilib_tree_banana_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- From ethereal:banana_trunk. Creates unilib:tree_banana_trunk_stripped
        part_name = "banana",
        orig_name = "ethereal:banana_trunk",

        replace_mode = mode,
        description = S("Banana Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
    })

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_banana_wood", "ethereal:banana_wood", mode, {
        -- From ethereal:banana_wood
        description = S("Banana Tree Wood Planks"),
        tiles = {"unilib_tree_banana_wood.png"},
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
        -- From ethereal:banana_wood
        output = "unilib:tree_banana_wood 4",
        recipe = {
            {"unilib:tree_banana_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("banana")

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_banana_leaves.png")
    unilib.register_node("unilib:tree_banana_leaves", "ethereal:bananaleaves", mode, {
        -- From ethereal:bananaleaves
        description = unilib.utils.annotate(S("Banana Tree Leaves"), sci_name),
        tiles = {"unilib_tree_banana_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_banana_sapling"}, rarity = 10},
                {items = {"unilib:tree_banana_leaves"}},
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
        -- From ethereal:bananaleaves
        trunk_type = "banana",
        trunks = {"unilib:tree_banana_trunk"},
        leaves = {"unilib:tree_banana_leaves"},
        others = {"unilib:fruit_banana", "unilib:fruit_banana_bunch"},
        radius = 3,
    })
    unilib.register_tree_leaves_compacted("unilib:tree_banana_leaves", mode)

    unilib.register_tree_sapling({
        -- From ethereal:banana_tree_sapling. Creates unilib:tree_banana_sapling
        part_name = "banana",
        orig_name = "ethereal:banana_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Banana Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 3, y = 8, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        offset_list = {3, 0, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_grove", "ethereal:grove_dirt"},

        replace_func = function(pos)

            if math.random(2) == 1 and
                    core.find_node_near(pos, 1, {"unilib:soil_ordinary_wet"}) then

                -- When growing near water, the tree has bunches, rather than single bananas
                return {["unilib:fruit_banana"] = "unilib:fruit_banana_bunch"}

            else

                -- Single bananas only, so no replacement table required (code in /lib/shared/trees/
                --      expects us to return nil, not an empty table)
                return nil

            end

        end,
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_banana. Creates unilib:tree_banana_wood_fence
        part_name = "banana",
        orig_name = "ethereal:fence_banana",

        replace_mode = mode,
        base_img = "unilib_tree_banana_wood.png",
        burnlevel = burnlevel,
        description = S("Banana Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_banana. Creates unilib:tree_banana_wood_fence_rail
        part_name = "banana",
        orig_name = "ethereal:fence_rail_banana",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_banana_wood.png",
        description = S("Banana Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_banana_closed, etc. Creates unilib:gate_banana_closed, etc
        part_name = "banana",
        orig_name = {"ethereal:fencegate_banana_closed", "ethereal:fencegate_banana_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Banana Tree Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_banana", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_banana.mts",

        fill_ratio = 0.015,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
