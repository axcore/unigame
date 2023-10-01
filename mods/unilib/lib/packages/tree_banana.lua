---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_banana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
        description = unilib.annotate(S("Banana Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_banana_trunk_top.png",
            "unilib_tree_banana_trunk_top.png",
            "unilib_tree_banana_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    if unilib.super_tree_table["banana"] ~= nil then

        unilib.register_tree_trunk_stripped({
            -- From ethereal:banana_trunk. Creates unilib:tree_banana_trunk_stripped
            part_name = "banana",
            orig_name = "ethereal:banana_trunk",

            replace_mode = mode,
            description = S("Banana Tree Trunk"),
            group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        })

    end

    unilib.register_node("unilib:tree_banana_wood", "ethereal:banana_wood", mode, {
        -- From ethereal:banana_wood
        description = S("Banana Tree Wood Planks"),
        tiles = {"unilib_tree_banana_wood.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From ethereal:banana_wood
        output = "unilib:tree_banana_wood 4",
        recipe = {
            {"unilib:tree_banana_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("banana")
    unilib.set_auto_rotate("unilib:tree_banana_wood", unilib.auto_rotate_wood_flag)

    local inv_img = unilib.filter_leaves_img("unilib_tree_banana_leaves.png")
    unilib.register_node("unilib:tree_banana_leaves", "ethereal:bananaleaves", mode, {
        -- From ethereal:bananaleaves
        description = unilib.annotate(S("Banana Tree Leaves"), sci_name),
        tiles = {"unilib_tree_banana_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_banana_sapling"}, rarity = 10},
                {items = {"unilib:tree_banana_leaves"}},
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
        -- From ethereal:bananaleaves
        trunks = {"unilib:tree_banana_trunk"},
        leaves = {"unilib:tree_banana_leaves", "unilib:fruit_banana", "unilib:fruit_banana_bunch"},
        radius = 3,
    })

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

            if math.random(3) == 1 and
                    minetest.find_node_near(pos, 1, {"unilib:soil_ordinary_wet"}) then

                -- When growing near water, the tree has bunches, rather than single bananas
                return {{"unilib:fruit_banana", "unilib:fruit_banana_bunch"}}

            else

                -- Single bananas only, so no replacement table required (/lib/shared/trees.lua
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
        -- From ethereal:fencegate_banana. Creates unilib:gate_banana_closed
        part_name = "banana",
        orig_name = {"ethereal:fencegate_banana_closed", "ethereal:fencegate_banana_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Banana Tree Wood Fence Gate"),
    })

    unilib.register_decoration("ethereal_tree_banana", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_banana.mts",

        fill_ratio = 0.015,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
