---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_olive = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_olive.init()

    return {
        description = "Olive tree",
        notes = "Produces olives",
        depends = "fruit_olive",
        optional = "dirt_ordinary_with_turf_grove",
    }

end

function unilib.pkg.tree_olive.exec()

    local burnlevel = 3
    local sci_name = "Olea europaea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "olive",
        description = S("Olive Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_olive_trunk", "ethereal:olive_trunk", mode, {
        -- From ethereal:olive_trunk
        description = unilib.annotate(S("Olive Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_olive_trunk_top.png",
            "unilib_tree_olive_trunk_top.png",
            "unilib_tree_olive_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    unilib.register_node("unilib:tree_olive_wood", "ethereal:olive_wood", mode, {
        -- From ethereal:olive_wood
        description = S("Olive Tree Wood Planks"),
        tiles = {"unilib_tree_olive_wood.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From ethereal:olive_wood
        output = "unilib:tree_olive_wood 4",
        recipe = {
            {"unilib:tree_olive_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("olive")
    unilib.set_auto_rotate("unilib:tree_olive_wood", unilib.auto_rotate_wood_flag)

    local inv_img = unilib.filter_leaves_img("unilib_tree_olive_leaves.png")
    unilib.register_node("unilib:tree_olive_leaves", "ethereal:olive_leaves", mode, {
        -- From ethereal:olive_leaves
        description = unilib.annotate(S("Olive Tree Leaves"), sci_name),
        tiles = {"unilib_tree_olive_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_olive_sapling"}, rarity = 25},
                {items = {"unilib:tree_olive_leaves"}},
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
        -- From ethereal:olive_leaves
        trunks = {"unilib:tree_olive_trunk"},
        leaves = {"unilib:tree_olive_leaves", "unilib:fruit_olive"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From ethereal:olive_tree_sapling. Creates unilib:tree_olive_sapling
        part_name = "olive",
        orig_name = "ethereal:olive_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Olive Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 7, z = 3},
        minp_table = {x = -4, y = 1, z = -3},
        offset_list = {3, 0, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_grove", "ethereal:grove_dirt"},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "olive",

        replace_mode = mode,
        burnlevel = burnlevel,
        fence_description = S("Olive Tree Wood Fence"),
        gate_description = S("Olive Tree Wood Fence Rail"),
        rail_description = S("Olive Tree Wood Fence Gate"),
    })

    unilib.register_decoration("ethereal_tree_olive", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_olive.mts",

        fill_ratio = 0.002,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
