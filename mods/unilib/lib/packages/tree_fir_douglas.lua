---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fir_douglas = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

local ltree_def_table = {
    trunk = "unilib:tree_fir_douglas_trunk",
--  leaves = nil,
    fruit = "unilib:ingredient_cone_fir_douglas",

    angle = 45,
    axiom = "FFFAF[&&-F][&&+F][&&---F][&&+++F]Fff",
    fruit_chance = 8,
    iterations = 7,
    random_level = 5,
--  rules_a = nil,
--  rules_b = nil,
    thin_branches = true,
    trunk_type = "single",
}

local ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
local ct_rules_b1 = "[-FBf][+FBf]"

local ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
local ct_rules_b2 = "[-fB][+fB]"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_grow(pos, iterations, random_level)

    local adj_def_table = table.copy(ltree_def_table)

    if math.random(2) == 1 then
        adj_def_table.leaves = "unilib:tree_fir_douglas_leaves_dark"
    else
        adj_def_table.leaves = "unilib:tree_fir_douglas_leaves_pale"
    end

    if math.random(2) == 1 then

        adj_def_table.rules_a = ct_rules_a1
        adj_def_table.rules_b = ct_rules_b1

    else

        adj_def_table.rules_a = ct_rules_a2
        adj_def_table.rules_b = ct_rules_b2

    end

    adj_def_table.iterations = iterations
    adj_def_table.random_level = random_level

    core.swap_node(pos, {name = "air"})

    -- N.B. This code exists in the original mod; its purpose seems to be, to replace any nearby
    --      apple tree leaves with air, leaving more room for the douglas fir tree to grow
    local leaf_list = core.find_nodes_in_area(

        {x = pos.x, y = pos.y, z = pos.z},
        {x = pos.x, y = pos.y + 5, z = pos.z},
        "unilib:tree_apple_leaves"
    )

    for leaf_name in ipairs(leaf_list) do
        core.swap_node(leaf_list[leaf_name], {name = "air"})
    end

    core.spawn_tree(pos, adj_def_table)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fir_douglas.grow_func(pos)
    do_grow(pos, 7, 5)
end

function unilib.pkg.tree_fir_douglas.snow_grow_func(pos)
    do_grow(pos, 2, 2)
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fir_douglas.init()

    return {
        description = "Douglas fir tree",
        notes = "Produces douglas fir tree cones",
        depends = {"ingredient_cone_fir_douglas", "shared_moretrees"},
    }

end

function unilib.pkg.tree_fir_douglas.exec()

    local burnlevel = 3
    local sci_name = "Pseudotsuga menziesii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fir_douglas",
        description = S("Douglas Fir Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:fir_trunk. Creates unilib:tree_fir_douglas_trunk
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_trunk",

        replace_mode = mode,
        description = S("Douglas Fir Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:fir_plank. Creates unilib:tree_fir_douglas_wood
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_plank",

        replace_mode = mode,
        description = S("Douglas Fir Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    -- (Two variants of leaves. Each tree uses one or the other exclusively)
    unilib.register_tree_leaves({
        -- From moretrees:fir_leaves. Creates unilib:tree_fir_douglas_leaves_dark
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_leaves",

        replace_mode = mode,
        description = S("Dark Douglas Fir Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
        variant_name = "dark",
    })
    unilib.register_craft({
        -- From moretrees:fir_leaves
        type = "fuel",
        recipe = "unilib:tree_fir_douglas_leaves_dark",
        burntime = 1,
    })

    unilib.register_tree_leaves({
        -- From moretrees:fir_leaves_bright. Creates unilib:tree_fir_douglas_leaves_pale
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_leaves_bright",

        replace_mode = mode,
        description = S("Pale Douglas Fir Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
        variant_name = "pale",
    })
    unilib.register_craft({
        -- From moretrees:fir_leaves
        type = "fuel",
        recipe = "unilib:tree_fir_douglas_leaves_pale",
        burntime = 1,
    })

    unilib.register_leafdecay({
        -- From moretrees:fir_leaves
        trunk_type = "fir_douglas",
        trunks = {"unilib:tree_fir_douglas_trunk"},
        leaves = {"unilib:tree_fir_douglas_leaves_dark", "unilib:tree_fir_douglas_leaves_pale"},
        others = {"unilib:ingredient_cone_fir_douglas"},
        radius = 5,
    })

    unilib.register_tree_sapling({
        -- From moretrees:fir_sapling. Creates unilib:tree_fir_douglas_sapling
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Douglas Fir Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        grow_func = unilib.pkg.tree_fir_douglas.grow_func,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:fir_fence. Creates unilib:tree_fir_douglas_wood_fence
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_fence",

        replace_mode = mode,
        base_img = "unilib_tree_fir_douglas_wood.png",
        description = S("Douglas Fir Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:fir_fence_rail. Creates unilib:tree_fir_douglas_wood_fence_rail
        part_name = "fir_douglas",
        orig_name = "moretrees:fir_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_fir_douglas_wood.png",
        description = S("Douglas Fir Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:fir_gate_closed, etc. Creates unilib:gate_fir_douglas_closed, etc
        part_name = "fir_douglas",
        orig_name = {"moretrees:fir_gate_closed", "moretrees:fir_gate_open"},

        replace_mode = mode,
        description = S("Douglas Fir Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fir_douglas"
        part_name = "tree_fir_douglas",
        convert_func = unilib.pkg.tree_fir_douglas.grow_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.utils.convert_biome_lib_temp(0.3),
            temp_min = unilib.utils.convert_biome_lib_temp(0.9),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 5,
            width = 5,
            sub_name = "unilib:tree_fir_douglas_sapling",
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fir_douglas_on_snow"
        part_name = "tree_fir_douglas_on_snow",
        convert_func = unilib.pkg.tree_fir_douglas.snow_grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 25,
            width = 7,
            sub_name = "unilib:tree_fir_douglas_sapling",
        },
    })

end
