---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_bamboo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_bamboo.init()

    return {
        description = "Bamboo tree",
        notes = "Produces bamboo sprouts (saplings) which are edible",
        optional = {"dirt_ordinary_with_turf_bamboo", "item_paper_ordinary"},
    }

end

function unilib.pkg.tree_bamboo.exec()

    -- (This value is only used for the sapling)
    local burnlevel = 1
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "bamboo",
        description = S("Bamboo Tree Stalk"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_bamboo_trunk", "ethereal:bamboo", mode, {
        -- From ethereal:bamboo
        description = S("Bamboo Tree Stalk"),
        tiles = {"unilib_tree_bamboo_trunk.png"},
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_tree_bamboo_trunk.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
        },
        sunlight_propagates = true,
        walkable = unilib.walkable_leaves_flag,
        wield_image = "unilib_tree_bamboo_trunk.png",

        after_dig_node = function(pos, node, metadata, digger)
            unilib.dig_up(pos, node, digger)
        end
    })
    unilib.register_craft({
        -- From ethereal:bamboo
        type = "fuel",
        recipe = "unilib:tree_bamboo_trunk",
        burntime = 2,
    })
    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From ethereal:bamboo
            output = "unilib:item_paper_ordinary 6",
            recipe = {
                {"unilib:tree_bamboo_trunk", "unilib:tree_bamboo_trunk"},
                {"unilib:tree_bamboo_trunk", "unilib:tree_bamboo_trunk"},
                {"unilib:tree_bamboo_trunk", "unilib:tree_bamboo_trunk"},
            }
        })

    end

    -- (Bamboo block instead of planks)
    unilib.register_node("unilib:tree_bamboo_block", "ethereal:bamboo_block", mode, {
        -- From ethereal:bamboo_block
        description = S("Bamboo Tree Block"),
        tiles = {"unilib_misc_flooring_bamboo.png"},
        groups = {choppy = 3 , flammable = 2, snappy = 3, wood = 1},
        sounds = unilib.sound_table.wood,

        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- From ethereal:bamboo_block
        output = "unilib:tree_bamboo_block",
        ingredient = "unilib:tree_bamboo_trunk",
    })
    unilib.register_stairs("unilib:tree_bamboo_block", {
        basic_flag = true,
    })

    unilib.register_node("unilib:tree_bamboo_leaves", "ethereal:bamboo_leaves", mode, {
        -- From ethereal:bamboo_leaves
        description = S("Bamboo Tree Leaves"),
        tiles = {"unilib_tree_bamboo_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_bamboo_sapling"}, rarity = 10},
                {items = {"unilib:tree_bamboo_leaves"}},
            },
        },
        inventory_image = "unilib_tree_bamboo_leaves.png",
        paramtype = "light",
        visual_scale = unilib.leaves_visual_scale,
        walkable = unilib.walkable_leaves_flag,
        waving = 1,
        wield_image = "unilib_tree_bamboo_leaves.png",

        after_place_node = unilib.after_place_leaves,
    })
    unilib.register_quick_tree_leafdecay("bamboo", 2)

    unilib.register_tree_sapling({
        -- From ethereal:bamboo_sprout. Creates unilib:tree_bamboo_sapling
        part_name = "bamboo",
        orig_name = "ethereal:bamboo_sprout",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Bamboo Tree Sprout"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 1, y = 18, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        offset_list = {1, 0, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_bamboo", "ethereal:bamboo_dirt"},
    })
    unilib.override_item("unilib:tree_bamboo_sapling", {
        groups = {
            attached_node = 1, dig_immediate = 3, flammable = 2, food_bamboo_sprout = 1,
            sapling = 1, snappy = 3,
        },
        sounds = unilib.sound_table.node,

        on_use = unilib.cuisine_eat_on_use("unilib:tree_bamboo_sapling", 2),
    })

    unilib.register_fence_quick({
        -- Original to unilib. Creates unilib:tree_bamboo_wood_fence
        part_name = "bamboo",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_misc_flooring_bamboo.png",
        burnlevel = burnlevel,
        description = S("Bamboo Tree Block Fence"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        ingredient = "unilib:tree_bamboo_block",
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_bamboo_wood_fence_rail
        part_name = "bamboo",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_misc_flooring_bamboo.png",
        burnlevel = burnlevel,
        description = S("Bamboo Tree Block Rail"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        ingredient = "unilib:tree_bamboo_block",
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_bamboo_closed
        part_name = "bamboo",
        orig_name = {nil, nil},

        replace_mode = mode,
        base_img = "unilib_misc_flooring_bamboo.png",
        burnlevel = burnlevel,
        description = S("Bamboo Tree Block Gate"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        ingredient = "unilib:tree_bamboo_block",
    })

    unilib.register_decoration("ethereal_tree_bamboo", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_bamboo.mts",

        fill_ratio = 0.025,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
