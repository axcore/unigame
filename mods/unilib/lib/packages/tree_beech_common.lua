---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_beech_common = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_beech_common.init()

    return {
        description = "Common beech tree",
        depends = "shared_moretrees",
    }

end

function unilib.pkg.tree_beech_common.exec()

    -- (no burnlevel)
    local sci_name = "Fagus sylvatica"

    unilib.register_tree({
        -- Original to unilib
        part_name = "beech_common",
        description = S("Common Beech Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:beech_trunk. Creates unilib:tree_beech_common_trunk
        part_name = "beech_common",
        orig_name = "moretrees:beech_trunk",

        replace_mode = mode,
        description = S("Common Beech Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From moretrees:beech_plank. Creates unilib:tree_beech_common_wood
        part_name = "beech_common",
        orig_name = "moretrees:beech_plank",

        replace_mode = mode,
        description = S("Common Beech Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:beech_leaves. Creates unilib:tree_beech_common_leaves
        part_name = "beech_common",
        orig_name = "moretrees:beech_leaves",

        replace_mode = mode,
        description = S("Common Beech Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("beech_common", 5)
    unilib.register_craft({
        -- From moretrees:beech_leaves
        type = "fuel",
        recipe = "unilib:tree_beech_common_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:beech_sapling. Creates unilib:tree_beech_common_sapling
        part_name = "beech_common",
        orig_name = "moretrees:beech_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Common Beech Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_beech_common_trunk",
            leaves = "unilib:tree_beech_common_leaves",

            angle = 30,
            axiom = "FFFFFBFB",
            iterations = 2,
            random_level = 0,
            rules_a = "[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]" ..
                    "//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fdd]]",
            rules_b = "[&&&F[++^Fd][--&d]//d[+^d][--&d]]////[&&&F[++^Fd][--&d]//d[+^d][--&d]]" ..
                    "////[&&&F[++^Fd][--&Fd]//d[+^d][--&d]]",
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
        -- From moretrees:beech_fence. Creates unilib:tree_beech_common_wood_fence
        part_name = "beech_common",
        orig_name = "moretrees:beech_fence",

        replace_mode = mode,
        base_img = "unilib_tree_beech_common_wood.png",
        description = S("Common Beech Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:beech_fence_rail. Creates unilib:tree_beech_common_wood_fence_rail
        part_name = "beech_common",
        orig_name = "moretrees:beech_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_beech_common_wood.png",
        description = S("Common Beech Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:beech_gate. Creates unilib:gate_beech_closed
        part_name = "beech_common",
        orig_name = {"moretrees:beech_gate_closed", "moretrees:beech_gate_open"},

        replace_mode = mode,
        description = S("Common Beech Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_beech_common"
        part_name = "tree_beech_common",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 8,
            width = 9,
            sub_name = "unilib:tree_beech_common_sapling",
        },
    })

end
