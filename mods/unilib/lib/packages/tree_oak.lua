---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak.init()

    return {
        description = "Oak tree",
        notes = "Produces acorns",
        depends = {"ingredient_acorn", "shared_moretrees"},
    }

end

function unilib.pkg.tree_oak.exec()

    local burnlevel = 5
    local sci_name = "Quercus robur"

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak",
        description = S("Oak Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:oak_trunk. Creates unilib:tree_oak_trunk
        part_name = "oak",
        orig_name = "moretrees:oak_trunk",

        replace_mode = mode,
        description = S("Oak Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:oak_plank. Creates unilib:tree_oak_wood
        part_name = "oak",
        orig_name = "moretrees:oak_plank",

        replace_mode = mode,
        description = S("Oak Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:oak_leaves. Creates unilib:tree_oak_leaves
        part_name = "oak",
        orig_name = "moretrees:oak_leaves",

        replace_mode = mode,
        description = S("Oak Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From moretrees:oak_leaves
        trunk_type = "oak",
        trunks = {"unilib:tree_oak_trunk"},
        leaves = {"unilib:tree_oak_leaves"},
        others = {"unilib:ingredient_acorn"},
        radius = 5,
    })
    unilib.register_craft({
        -- From moretrees:oak_leaves
        type = "fuel",
        recipe = "unilib:tree_oak_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:oak_sapling. Creates unilib:tree_oak_sapling
        part_name = "oak",
        orig_name = "moretrees:oak_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Oak Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_oak_trunk",
            leaves = "unilib:tree_oak_leaves",
            fruit = "unilib:ingredient_acorn",

            angle = 30,
            axiom = "FFFFFFA",
            fruit_chance = 3,
            iterations = 5,
            random_level = 2,
            rules_a = "[&FFBFA]////[&BFFFA]////[&FBFFA]",
            rules_b = "[&FFFA]////[&FFFA]////[&FFFA]",
            thin_branches = false,
            trunk_type = "crossed",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:oak_fence. Creates unilib:tree_oak_wood_fence
        part_name = "oak",
        orig_name = "moretrees:oak_fence",

        replace_mode = mode,
        base_img = "unilib_tree_oak_wood.png",
        description = S("Oak Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:oak_fence_rail. Creates unilib:tree_oak_wood_fence_rail
        part_name = "oak",
        orig_name = "moretrees:oak_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_oak_wood.png",
        description = S("Oak Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:oak_gate_closed, etc. Creates unilib:gate_oak_closed, etc
        part_name = "oak",
        orig_name = {"moretrees:oak_gate_closed", "moretrees:oak_gate_open"},

        replace_mode = mode,
        description = S("Oak Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_oak"
        part_name = "tree_oak",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.utils.convert_biome_lib_temp(0.2),
            temp_min = unilib.utils.convert_biome_lib_temp(0.4),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 21,
            width = 23,
            sub_name = "unilib:tree_oak_sapling",
        },
    })

end
