---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_apple_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_apple_mature.init()

    return {
        description = "Mature apple tree",
        notes = "Produces apples",
        depends = {"fruit_apple", "shared_moretrees"},
    }

end

function unilib.pkg.tree_apple_mature.exec()

    local burnlevel = 4
    local sci_name = "Malus sieversii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "apple_mature",
        description = S("Mature Apple Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:apple_tree_trunk. Creates unilib:tree_apple_mature_trunk
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_trunk",

        replace_mode = mode,
        description = S("Mature Apple Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:apple_tree_plank. Creates unilib:tree_apple_mature_wood
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_plank",

        replace_mode = mode,
        description = S("Mature Apple Tree Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:apple_tree_leaves. Creates unilib:tree_apple_mature_leaves
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_leaves",

        replace_mode = mode,
        description = S("Mature Apple Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From moretrees:apple_tree_leaves
        trunk_type = "apple_mature",
        trunks = {"unilib:tree_apple_mature_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_apple_mature_leaves"},
        others = {"unilib:fruit_apple"},
        radius = 5,
    })
    unilib.register_craft({
        -- From moretrees:apple_tree_leaves
        type = "fuel",
        recipe = "unilib:tree_apple_mature_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:apple_tree_sapling. Creates unilib:tree_apple_mature_sapling
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Mature Apple Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_apple_mature_trunk",
            leaves = "unilib:tree_apple_mature_leaves",
            fruit = "unilib:fruit_apple",

            angle = 30,
            axiom = "FFFFFAFFBF",
            fruit_chance = 15,
            iterations = 2,
            rules_a = "[&&&FFFFF&&FFFF][&&&++++FFFFF&&FFFF][&&&----FFFFF&&FFFF]",
            rules_b = "[&&&++FFFFF&&FFFF][&&&--FFFFF&&FFFF][&&&------FFFFF&&FFFF]",
            random_level = 0,
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
        -- From moretrees:apple_tree_fence. Creates unilib:tree_apple_mature_wood_fence
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_fence",

        replace_mode = mode,
        base_img = "unilib_tree_apple_mature_wood.png",
        description = S("Mature Apple Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:apple_tree_fence_rail. Creates unilib:tree_apple_mature_wood_fence_rail
        part_name = "apple_mature",
        orig_name = "moretrees:apple_tree_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_apple_mature_wood.png",
        description = S("Mature Apple Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:apple_tree_gate_closed, etc. Creates unilib:gate_apple_mature_closed, etc
        part_name = "apple_mature",
        orig_name = {"moretrees:apple_tree_gate_closed", "moretrees:apple_tree_gate_open"},

        replace_mode = mode,
        description = S("Mature Apple Tree Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_apple_mature"
        part_name = "tree_apple_mature",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.utils.convert_biome_lib_temp(-0.15),
            temp_min = unilib.utils.convert_biome_lib_temp(0.1),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 75,
            }),
        },
        space_table = {
            height = 9,
            width = 15,
            sub_name = "unilib:tree_apple_mature_sapling",
        },
    })

end
