---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jungle_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

local ltree_def_table = {
    trunk = "unilib:tree_jungle_trunk",
    leaves = "unilib:tree_jungle_leaves",

    angle = 45,
--  axiom = nil,
    -- N.B. Commented out fruit, as vines isn't a supported mod at the moment
--  fruit_chance = 15,
--  fruit = "vines:vine"
--  iterations = nil,
--  leaves2 = nil,
--  leaves2_chance = nil,
    random_level = 2,
--  rules_a = nil,
--  rules_b = nil,
    thin_branches = true,
--  trunk_type = nil,
}

local jt_axiom1 = "FFFA"
local jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff]" ..
        "[&&+++FBFf[&&&Ff]^^^Ff]F/A"
local jt_rules_b1 = "[-Ff&f][+Ff&f]B"

local jt_axiom2 = "FFFFFA"
local jt_rules_a2 = "FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf]" ..
        "[&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
local jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

local ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
local ct_rules_b1 = "[-FBf][+FBf]"

local ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
local ct_rules_b2 = "[-fB][+fB]"

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle_large.grow_func(pos)

    local adj_def_table = table.copy(ltree_def_table)

    local r1 = math.random(2)
    local r2 = math.random(3)

    if r1 == 1 then
        adj_def_table.leaves2 = "unilib:tree_jungle_leaves_red"
    else
        adj_def_table.leaves2 = "unilib:tree_jungle_leaves_yellow"
    end

    adj_def_table.leaves2_chance = math.random(25, 75)

    if r2 == 1 then

        adj_def_table.trunk_type = "single"
        adj_def_table.iterations = 2
        adj_def_table.axiom = jt_axiom1
        adj_def_table.rules_a = jt_rules_a1
        adj_def_table.rules_b = jt_rules_b1

    elseif r2 == 2 then

        adj_def_table.trunk_type = "double"
        adj_def_table.iterations = 4
        adj_def_table.axiom = jt_axiom2
        adj_def_table.rules_a = jt_rules_a2
        adj_def_table.rules_b = jt_rules_b2

    elseif r2 == 3 then

        adj_def_table.trunk_type = "crossed"
        adj_def_table.iterations = 4
        adj_def_table.axiom = jt_axiom2
        adj_def_table.rules_a = jt_rules_a2
        adj_def_table.rules_b = jt_rules_b2

    end

    core.swap_node(pos, {name = "air"})

    -- N.B. This code exists in the original mod; its purpose seems to be, to replace any nearby
    --      apple tree leaves with air, leaving more room for the jungle tree to grow
    local leaf_list = core.find_nodes_in_area(
        {x = pos.x - 1, y = pos.y, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 10, z = pos.z + 1},
        "unilib:tree_apple_leaves"
    )

    for leaf_name in ipairs(leaf_list) do
        core.swap_node(leaf_list[leaf_name], {name = "air"})
    end

    core.spawn_tree(pos, adj_def_table)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle_large.init()

    return {
        description = "Large jungle tree",
        notes = "A little larger than an emergent jungle tree. Has red/yellow leaf variants" ..
                " which drop saplings for large trees",
        depends = {"shared_moretrees", "tree_jungle"},
    }

end

function unilib.pkg.tree_jungle_large.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "jungle_large",
        -- N.B. Not "Large Jungle Tree Wood", obviously
        description = S("Jungle Tree Wood"),

        not_super_flag = true,
    })

    -- (trunk, wood and leaves from the "tree_jungle" package)

    -- The large tree has a few red/yellow leaves (not original to unilib); they are the ones that
    --      drop the "large" sapling (original to unilib)
    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_jungle_leaves_red.png")
    unilib.register_node(
        -- From moretrees:jungletree_leaves_red
        "unilib:tree_jungle_leaves_red",
        "moretrees:jungletree_leaves_red",
        mode,
        {
            description = unilib.utils.brackets(S("Jungle Tree Leaves"), S("Reddening")),
            tiles = {"unilib_tree_jungle_leaves_red.png"},
               groups = {flammable = 2, leaves = 1, leafdecay = 3, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

--          drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_jungle_sapling_large"}, rarity = 100},
                    {items = {"unilib:tree_jungle_leaves_red"}},
                },
            },
            inventory_image = inv_img,
            is_ground_content = false,
            paramtype = "light",
--          visual_scale = 1,
            waving = 1,
            wield_img = inv_img,

            after_place_node = unilib.flora.after_place_leaves,
        }
    )
    unilib.register_tree_leaves_compacted("unilib:tree_jungle_leaves_red", mode)

    inv_img = unilib.flora.filter_leaves_img("unilib_tree_jungle_leaves_yellow.png")
    unilib.register_node(
        -- From moretrees:jungletree_leaves_yellow
        "unilib:tree_jungle_leaves_yellow",
        "moretrees:jungletree_leaves_yellow",
        mode,
        {
            description = unilib.utils.brackets(S("Jungle Tree Leaves"), S("Yellowing")),
            tiles = {"unilib_tree_jungle_leaves_yellow.png"},
               groups = {flammable = 2, leaves = 1, leafdecay = 3, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

--          drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_jungle_sapling_large"}, rarity = 100},
                    {items = {"unilib:tree_jungle_leaves_yellow"}},
                },
            },
            inventory_image = inv_img,
            is_ground_content = false,
            paramtype = "light",
--          visual_scale = 1,
            waving = 1,
            wield_img = inv_img,

            after_place_node = unilib.flora.after_place_leaves,
        }
    )
    unilib.register_tree_leaves_compacted("unilib:tree_jungle_leaves_yellow", mode)

    unilib.register_leafdecay({
        -- From moretrees/node_defs.lua
        trunk_type = "jungle",
        trunks = {"unilib:tree_jungle_trunk"},
        leaves = {
            "unilib:tree_jungle_leaves",
            "unilib:tree_jungle_leaves_red",
            "unilib:tree_jungle_leaves_yellow",
        },
        radius = 5,
    })

    unilib.register_tree_sapling({
        -- From moretrees:jungletree_sapling. Creates unilib:tree_jungle_sapling_large
        part_name = "jungle",
        orig_name = "moretrees:jungletree_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Jungle Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        grow_func = unilib.pkg.tree_jungle_large.grow_func,
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
        variant_name = "large",
    })

    -- (fences and gates from the "tree_jungle" package)

    -- N.B. In order to make large jungle trees grow in actual jungles, don't check surrounding
    --          space, and only grow on rainforest litter
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_jungle_large"
        part_name = "tree_jungle_large",
        convert_func = unilib.pkg.tree_jungle_large.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                plantlife_limit = -0.9,
                rarity = 85,
            }),
        },
--      space_table = {
--          height = 34,
--          width = 13,
--          sub_name = "unilib:tree_jungle_sapling",
--      },
    })

end
