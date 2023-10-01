---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_sequoia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_sequoia.init()

    return {
        description = "Giant sequoia tree",
        depends = "shared_moretrees",
    }

end

function unilib.pkg.tree_sequoia.exec()

    -- (no burnlevel)
    local sci_name = "Sequoiadendron giganteum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "sequoia",
        description = S("Giant Sequoia Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:sequoia_trunk. Creates unilib:tree_sequoia_trunk
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_trunk",

        replace_mode = mode,
        description = S("Giant Sequoia Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
        strip_flag = true,
    })

    unilib.register_tree_wood({
        -- From moretrees:sequoia_plank. Creates unilib:tree_sequoia_wood
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_plank",

        replace_mode = mode,
        description = S("Giant Sequoia Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:sequoia_leaves. Creates unilib:tree_sequoia_leaves
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_leaves",

        replace_mode = mode,
        description = S("Giant Sequoia Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("sequoia", 5)
    unilib.register_craft({
        -- From moretrees:sequoia_leaves
        type = "fuel",
        recipe = "unilib:tree_sequoia_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:sequoia_sapling. Creates unilib:tree_sequoia_sapling
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Giant Sequoia Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_sequoia_trunk",
            leaves = "unilib:tree_sequoia_leaves",

            angle = 30,
            axiom = "FFFFFFFFFFddccA///cccFddcFA///ddFcFA/cFFddFcdBddd/A/ccdcddd/" ..
                    "ccAddddcFBcccAccFdFcFBcccc/BFdFFcFFdcccc/B",
            iterations = 2,
            random_level = 0,
            rules_a = "[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd]" ..
                    "[--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd]" ..
                    "[--&Fdd]]",
            rules_b = "[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]" ..
                    "//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
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
        -- From moretrees:sequoia_fence. Creates unilib:tree_sequoia_wood_fence
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_fence",

        replace_mode = mode,
        base_img = "unilib_tree_sequoia_wood.png",
        description = S("Giant Sequoia Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:sequoia_fence_rail. Creates unilib:tree_sequoia_wood_fence_rail
        part_name = "sequoia",
        orig_name = "moretrees:sequoia_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_sequoia_wood.png",
        description = S("Giant Sequoia Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:sequoia_gate. Creates unilib:gate_sequoia_closed
        part_name = "sequoia",
        orig_name = {"moretrees:sequoia_gate_closed", "moretrees:sequoia_gate_open"},

        replace_mode = mode,
        description = S("Giant Sequoia Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_sequoia"
        part_name = "tree_sequoia",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.convert_biome_lib_temp(-0.4),
            temp_min = unilib.convert_biome_lib_temp(1),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 90,
            }),
        },
        space_table = {
            height = 43,
            width = 15,
            sub_name = "unilib:tree_sequoia_sapling",
        },
    })

end
