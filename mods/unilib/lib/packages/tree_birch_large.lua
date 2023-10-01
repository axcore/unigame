---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_birch_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

local ltree_model = {
    trunk = "unilib:tree_birch_trunk",
    leaves = "unilib:tree_birch_leaves",

    angle = 30,
    axiom = "FFFFFdddccA/FFFFFFcA/FFFFFFcB",
    iterations = 2,
    random_level = 0,
    rules_a = "[&&&dddd^^ddddddd][&&&---dddd^^ddddddd][&&&+++dddd^^ddddddd]" ..
            "[&&&++++++dddd^^ddddddd]",
    rules_b = "[&&&ddd^^ddddd][&&&---ddd^^ddddd][&&&+++ddd^^ddddd][&&&++++++ddd^^ddddd]",
    rules_c = "/",
    rules_d = "F",
    thin_branches = true,
    trunk_type = "single",
}

local ltree_model2 = {
    trunk = "unilib:tree_birch_trunk",
    leaves = "unilib:tree_birch_leaves",

    angle = 30,
    axiom = "FFFdddccA/FFFFFccA/FFFFFccB",
    iterations = 2,
    random_level = 0,
    rules_a = "[&&&dFFF^^FFFdd][&&&---dFFF^^FFFdd][&&&+++dFFF^^FFFdd][&&&++++++dFFF^^FFFdd]",
    rules_b = "[&&&dFF^^FFFd][&&&---dFFF^^FFFd][&&&+++dFF^^FFFd][&&&++++++dFF^^FFFd]",
    rules_c = "/",
    rules_d = "F",
    thin_branches = true,
    trunk_type = "single",
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_birch_large.grow_func(pos)

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

function unilib.pkg.tree_birch_large.init()

    return {
        description = "Large birch tree",
        depends = {"shared_moretrees", "tree_birch"}
    }

end

function unilib.pkg.tree_birch_large.exec()

    -- (no burnlevel)
    local sci_name = "Betula"

    unilib.register_tree({
        -- Original to unilib
        part_name = "birch_large",
        -- N.B. Not "Large Birch Wood", obviously
        description = S("Birch Wood"),

        not_super_flag = true,
    })

    -- (trunk, wood and leaves from the "tree_birch" package)

    unilib.override_item("unilib:tree_birch_leaves", {
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_birch_sapling"}, rarity = 20},
                {items = {"unilib:tree_birch_large_sapling"}, rarity = 100},
                {items = {"unilib:tree_birch_leaves"}},
            },
        },
    })

    unilib.register_tree_sapling({
        -- From moretrees:birch_sapling. Creates unilib:tree_birch_large_sapling
        part_name = "birch_large",
        orig_name = "moretrees:birch_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Large Birch Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        grow_func = unilib.pkg.tree_birch_large.grow_func,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    -- (fences and gates from the "tree_birch" package)

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_birch_large"
        part_name = "tree_birch_large",
        convert_func = unilib.pkg.tree_birch_large.grow_func,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.convert_biome_lib_temp(0.3),
            temp_min = unilib.convert_biome_lib_temp(0.9),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 21,
            width = 15,
            sub_name = "unilib:tree_birch_large_sapling",
        },
    })

end
