---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_willow_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_willow_large.init()

    return {
        description = "Large willow tree",
        depends = "shared_moretrees",
    }

end

function unilib.pkg.tree_willow_large.exec()

    local burnlevel = 2
    local sci_name = "Salix"

    unilib.register_tree({
        -- Original to unilib
        part_name = "willow_large",
        description = S("Large Willow Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:willow_trunk. Creates unilib:tree_willow_large_trunk
        part_name = "willow_large",
        orig_name = "moretrees:willow_trunk",

        replace_mode = mode,
        description = S("Large Willow Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:willow_plank. Creates unilib:tree_willow_large_wood
        part_name = "willow_large",
        orig_name = "moretrees:willow_plank",

        replace_mode = mode,
        description = S("Large Willow Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:willow_leaves. Creates unilib:tree_willow_large_leaves
        part_name = "willow_large",
        orig_name = "moretrees:willow_leaves",

        replace_mode = mode,
        description = S("Large Willow Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("willow_large", 5)
    unilib.register_craft({
        -- From moretrees:willow_leaves
        type = "fuel",
        recipe = "unilib:tree_willow_large_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:willow_sapling. Creates unilib:tree_willow_large_sapling
        part_name = "willow_large",
        orig_name = "moretrees:willow_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Large Willow Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_willow_large_trunk",
            leaves = "unilib:tree_willow_large_leaves",

            angle = 30,
            axiom = "FFFFFFFFccA",
            iterations = 2,
            random_level = 0,
            rules_a = "[&FF&FFFF&&F&FFFFFFFdddd][**&FF&FFFF&&F&FFFFFFFdddd]" ..
                    "[//&FF&FFFF&&F&FFFFFFFdddd][////&FF&FFFF&&F&FFFFFFFdddd]" ..
                    "[//////&FF&FFFF&&F&FFFFFFFdddd][////////&FF&FFFF&&F&FFFFFFFdddd]",
            rules_c = "/",
            rules_d = "F",
            thin_branches = true,
            trunk_type = "crossed",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:willow_fence. Creates unilib:tree_willow_large_wood_fence
        part_name = "willow_large",
        orig_name = "moretrees:willow_fence",

        replace_mode = mode,
        base_img = "unilib_tree_willow_large_wood.png",
        description = S("Large Willow Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:willow_fence_rail. Creates unilib:tree_willow_large_wood_fence_rail
        part_name = "willow_large",
        orig_name = "moretrees:willow_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_willow_large_wood.png",
        description = S("Large Willow Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:willow_gate_closed, etc. Creates unilib:gate_willow_closed, etc
        part_name = "willow_large",
        orig_name = {"moretrees:willow_gate_closed", "moretrees:willow_gate_open"},

        replace_mode = mode,
        description = S("Large Willow Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_willow_large"
        part_name = "tree_willow_large",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 75,
            }),
        },
        space_table = {
            height = 14,
            width = 21,
            sub_name = "unilib:tree_willow_large_sapling",
        },
    })

end
