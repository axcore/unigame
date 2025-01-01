---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_poplar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

local large_ltree_def_table = {
    trunk = "unilib:tree_poplar_trunk",
    leaves = "unilib:tree_poplar_leaves",

    angle = 45,
    axiom = "TTTaaBCCCCCCCCCCCcccBBB[[f]&&G++f++Gf++Gf++Gf++G--]G[[f]&&G++f++Gf++Gf++Gf++G--]Gff",
    iterations = 0,
    rules_a = "T",
    rules_b = "[[T]&&G++f++ff++ff++ff++f--]G",
    rules_c = "[[T]&&G++f++ff++ff++ff++f--G++[d]G[d]G++G[d]G[d]G[d]G++G[d]G[d]G[d]G++G[d]G[d]" ..
            "G[d]G++G[d]G]G",
    rules_d = "f",
    random_level = 0,
    thin_branches = false,
    trunk_type = "single",
}

local small_ltree_def_table = {
    trunk = "unilib:tree_poplar_trunk",
    leaves = "unilib:tree_poplar_leaves",

    angle = 45,
    axiom = "TT[T]BCCCCccBBff",
    iterations = 0,
    random_level = 0,
    rules_a = "T",
    rules_b = "[[f]&&G++f++Gf++Gf++Gf++G--]G",
    rules_c = "[[T]&&G++f++[d]Gf++[d]Gf++[d]Gf++[d]G--]G",
    rules_d = "f",
    thin_branches = false,
    trunk_type = "single",
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_poplar.init()

    return {
        description = "Poplar tree",
        depends = "shared_moretrees",
    }

end

function unilib.pkg.tree_poplar.exec()

    local burnlevel = 1
    local sci_name = "Populus nigra"

    unilib.register_tree({
        -- Original to unilib
        part_name = "poplar",
        description = S("Poplar Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:poplar_trunk. Creates unilib:tree_poplar_trunk
        part_name = "poplar",
        orig_name = "moretrees:poplar_trunk",

        replace_mode = mode,
        description = S("Poplar Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:poplar_plank. Creates unilib:tree_poplar_wood
        part_name = "poplar",
        orig_name = "moretrees:poplar_plank",

        replace_mode = mode,
        description = S("Poplar Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:poplar_leaves. Creates unilib:tree_poplar_leaves
        part_name = "poplar",
        orig_name = "moretrees:poplar_leaves",

        replace_mode = mode,
        description = S("Poplar Tree Leaves"),
        drop_table = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_poplar_sapling"}, rarity = 133},
                {items = {"unilib:tree_poplar_sapling_small"}, rarity = 133},
                {items = {"unilib:tree_poplar_leaves"}},
            },
        },
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("poplar", 5)
    unilib.register_craft({
        -- From moretrees:poplar_leaves
        type = "fuel",
        recipe = "unilib:tree_poplar_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:poplar_sapling. Creates unilib:tree_poplar_sapling
        part_name = "poplar",
        orig_name = "moretrees:poplar_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Poplar Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = large_ltree_def_table,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    -- (A smaller sapling, producing a smaller tree)
    unilib.register_tree_sapling({
        -- From moretrees:poplar_small_sapling. Creates unilib:tree_poplar_sapling_small
        part_name = "poplar",
        orig_name = "moretrees:poplar_small_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Small Poplar Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = small_ltree_def_table,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
        variant_name = "small",
    })

    unilib.register_fence_quick({
        -- From moretrees:poplar_fence. Creates unilib:tree_poplar_wood_fence
        part_name = "poplar",
        orig_name = "moretrees:poplar_fence",

        replace_mode = mode,
        base_img = "unilib_tree_poplar_wood.png",
        description = S("Poplar Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:poplar_fence_rail. Creates unilib:tree_poplar_wood_fence_rail
        part_name = "poplar",
        orig_name = "moretrees:poplar_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_poplar_wood.png",
        description = S("Poplar Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:poplar_gate_closed, etc. Creates unilib:gate_poplar_closed, etc
        part_name = "poplar",
        orig_name = {"moretrees:poplar_gate_closed", "moretrees:poplar_gate_open"},

        replace_mode = mode,
        description = S("Poplar Wood Fence Gate"),
    })

    -- N.B. Here, we only use the first of several similar biome_lib decorations
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_poplar"
        part_name = "tree_poplar",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.utils.convert_biome_lib_temp(-1),
            humidity_min = unilib.utils.convert_biome_lib_temp(-0.7),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 50,
            }),
        },
        -- (Use the height of the small tree, and the width of the large tree)
        space_table = {
            height = 13,
            width = 5,
            sub_name = "unilib:tree_poplar_sapling",
        },
    })

end
