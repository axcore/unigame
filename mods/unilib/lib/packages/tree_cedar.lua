---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cedar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cedar.init()

    return {
        description = "Cedar tree",
        notes = "Produces cedar tree cones",
        depends = {"ingredient_cone_cedar", "shared_moretrees"},
    }

end

function unilib.pkg.tree_cedar.exec()

    -- (no burnlevel)
    local sci_name = "Cedrus libani"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cedar",
        description = S("Cedar Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:cedar_trunk. Creates unilib:tree_cedar_trunk
        part_name = "cedar",
        orig_name = "moretrees:cedar_trunk",

        replace_mode = mode,
        description = S("Cedar Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From moretrees:cedar_plank. Creates unilib:tree_cedar_wood
        part_name = "cedar",
        orig_name = "moretrees:cedar_plank",

        replace_mode = mode,
        description = S("Cedar Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:cedar_leaves. Creates unilib:tree_cedar_leaves
        part_name = "cedar",
        orig_name = "moretrees:cedar_leaves",

        replace_mode = mode,
        description = S("Cedar Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From moretrees:cedar_leaves
        trunks = {"unilib:tree_cedar_trunk"},
        leaves = {"unilib:tree_cedar_leaves", "unilib:ingredient_cone_cedar"},
        radius = 5,
    })
    unilib.register_craft({
        -- From moretrees:cedar_leaves
        type = "fuel",
        recipe = "unilib:tree_cedar_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:cedar_sapling. Creates unilib:tree_cedar_sapling
        part_name = "cedar",
        orig_name = "moretrees:cedar_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Cedar Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_cedar_trunk",
            leaves = "unilib:tree_cedar_leaves",
            fruit = "unilib:ingredient_cone_cedar",

            angle = 30,
            axiom = "FFFFFcccdddB///cFdFB////cFdFB///cFdFB///cFdFA///cFdFA///cFdFB[FF]f",
            fruit_chance = 8,
            iterations = 2,
            random_level = 0,
            rules_a = "[&&&TTTT[++^TFdd][--&TFd]//Tdd[+^Fd][--&Fdd]]",
            rules_b = "[&&&TTT[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
            rules_c = "/",
            rules_d = "F",
            thin_branches = true,
            trunk_type = "single",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:cedar_fence. Creates unilib:tree_cedar_wood_fence
        part_name = "cedar",
        orig_name = "moretrees:cedar_fence",

        replace_mode = mode,
        base_img = "unilib_tree_cedar_wood.png",
        description = S("Cedar Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:cedar_fence_rail. Creates unilib:tree_cedar_wood_fence_rail
        part_name = "cedar",
        orig_name = "moretrees:cedar_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_cedar_wood.png",
        description = S("Cedar Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:cedar_gate. Creates unilib:gate_cedar_closed
        part_name = "cedar",
        orig_name = {"moretrees:cedar_gate_closed", "moretrees:cedar_gate_open"},

        replace_mode = mode,
        description = S("Cedar Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_cedar"
        part_name = "tree_cedar",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 25,
            width = 15,
            sub_name = "unilib:tree_cedar_sapling",
        },
    })

end
