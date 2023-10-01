---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_spruce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

local ltree_model = {
    trunk = "unilib:tree_spruce_trunk",
    leaves = "unilib:tree_spruce_leaves",
    fruit = "unilib:ingredient_cone_spruce",

    angle = 30,
    axiom = "FFFFFAFFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF]" ..
            "[&&&++++++F^^FF][&&&--F^^FF][&&&----F^^FF][FFFFf]",
    fruit_chance = 8,
    iterations = 2,
    random_level = 0,
    rules_a = "[&&&FFFFFF^^FFF][&&&++FFFFFF^^FFF][&&&++++FFFFFF^^FFF][&&&++++++FFFFFF^^FFF]" ..
            "[&&&--FFFFFF^^FFF][&&&----FFFFFF^^FFF]",
    rules_b = "[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF]" ..
            "[&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
    rules_c = "[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF]" ..
            "[&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
    rules_d = "[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF]" ..
            "[&&&----FFF^^FFF]",
    thin_branches = true,
    trunk_type = "crossed",
}

local ltree_model2 = {
    trunk = "unilib:tree_spruce_trunk",
    leaves = "unilib:tree_spruce_leaves",
    fruit = "unilib:ingredient_cone_spruce",

    angle = 30,
    axiom = "FFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF][&&&++++++F^^FF]" ..
            "[&&&--F^^FF][&&&----F^^FF][FFFFf]",
    fruit_chance = 8,
    iterations = 2,
    rules_b = "[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF]" ..
            "[&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
    rules_c = "[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF]" ..
            "[&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
    rules_d = "[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF]" ..
            "[&&&----FFF^^FFF]",
    random_level = 0,
    thin_branches = true,
    trunk_type = "crossed",
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_spruce.grow_func(pos)

    minetest.swap_node(pos, {name = "air"})

    if math.random(2) == 1 then
        minetest.spawn_tree(pos, ltree_model)
    else
        minetest.spawn_tree(pos, ltree_model2)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_spruce.init()

    return {
        description = "Spruce tree",
        notes = "Produces spruce cones",
        depends = {"ingredient_cone_spruce", "shared_moretrees"},
    }

end

function unilib.pkg.tree_spruce.exec()

    -- (no burnlevel)
    local sci_name = "Picea abies"

    unilib.register_tree({
        -- Original to unilib
        part_name = "spruce",
        description = S("Spruce Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:spruce_trunk. Creates unilib:tree_spruce_trunk
        part_name = "spruce",
        orig_name = "moretrees:spruce_trunk",

        replace_mode = mode,
        description = S("Spruce Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From moretrees:spruce_plank. Creates unilib:tree_spruce_wood
        part_name = "spruce",
        orig_name = "moretrees:spruce_plank",

        replace_mode = mode,
        description = S("Spruce Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:spruce_leaves. Creates unilib:tree_spruce_leaves
        part_name = "spruce",
        orig_name = "moretrees:spruce_leaves",

        replace_mode = mode,
        description = S("Spruce Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From moretrees:spruce_leaves
        trunks = {"unilib:tree_spruce_trunk"},
        leaves = {"unilib:tree_spruce_leaves", "unilib:ingredient_cone_spruce"},
        radius = 5,
    })
    unilib.register_craft({
        -- From moretrees:spruce_leaves
        type = "fuel",
        recipe = "unilib:tree_spruce_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:spruce_sapling. Creates unilib:tree_spruce_sapling
        part_name = "spruce",
        orig_name = "moretrees:spruce_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Spruce Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        grow_func = unilib.pkg.tree_spruce.grow_func,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:spruce_fence. Creates unilib:tree_spruce_wood_fence
        part_name = "spruce",
        orig_name = "moretrees:spruce_fence",

        replace_mode = mode,
        base_img = "unilib_tree_spruce_wood.png",
        description = S("Spruce Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:spruce_fence_rail. Creates unilib:tree_spruce_wood_fence_rail
        part_name = "spruce",
        orig_name = "moretrees:spruce_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_spruce_wood.png",
        description = S("Spruce Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:spruce_gate. Creates unilib:gate_spruce_closed
        part_name = "spruce",
        orig_name = {"moretrees:spruce_gate_closed", "moretrees:spruce_gate_open"},

        replace_mode = mode,
        description = S("Spruce Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_spruce"
        part_name = "tree_spruce",
        convert_func = unilib.pkg.tree_spruce.grow_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.convert_biome_lib_temp(0.7),
            temp_min = unilib.convert_biome_lib_temp(0.9),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 29,
            width = 13,
            sub_name = "unilib:tree_spruce_sapling",
        },
    })

end
