---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pahautea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pahautea.init()

    return {
        description = "Pahuatea tree",
    }

end

function unilib.pkg.tree_pahautea.exec()

    -- (no burnlevel)
    local sci_name = "Libocedrus bidwillii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pahautea",
        description = S("Pahuatea Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:pahautea_tree. Creates unilib:tree_pahautea_trunk
        part_name = "pahautea",
        orig_name = "aotearoa:pahautea_tree",

        replace_mode = mode,
        description = S("Pahuatea Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:pahautea_wood. Creates unilib:tree_pahautea_wood
        part_name = "pahautea",
        orig_name = "aotearoa:pahautea_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Pahuatea Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:pahautea_leaves. Creates unilib:tree_pahautea_leaves
        part_name = "pahautea",
        orig_name = "aotearoa:pahautea_leaves",

        replace_mode = mode,
        description = S("Pahuatea Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("pahautea", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:pahautea_sapling. Creates unilib:tree_pahautea_sapling
        part_name = "pahautea",
        orig_name = "aotearoa:pahautea_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Pahuatea Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_pahautea_1", 7, 1, 7},
            {"unilib_tree_pahautea_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_pahautea_wood. Creates unilib:tree_pahautea_wood_fence
        part_name = "pahautea",
        orig_name = "aotearoa:fence_pahautea_wood",

        replace_mode = mode,
        base_img = "unilib_tree_pahautea_wood.png",
        description = S("Pahuatea Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pahautea_wood_fence_rail
        part_name = "pahautea",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pahautea_wood.png",
        description = S("Pahuatea Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_pahautea_wood. Creates unilib:gate_pahautea_closed
        part_name = "pahautea",
        orig_name = {"aotearoa:gate_pahautea_wood_closed", "aotearoa:gate_pahautea_wood_open"},

        replace_mode = mode,
        description = S("Pahuatea Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_pahautea_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pahautea_" .. i .. ".mts",

            fill_ratio = 0.0117,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
