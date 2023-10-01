---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_tawa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_tawa.init()

    return {
        description = "Tawa tree",
        notes = "Produces tawa fruits",
        depends = "fruit_tawa",
    }

end

function unilib.pkg.tree_tawa.exec()

    -- (no burnlevel)
    local sci_name = "Beilschmiedia tawa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "tawa",
        description = S("Tawa Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:tawa_tree. Creates unilib:tree_tawa_trunk
        part_name = "tawa",
        orig_name = "aotearoa:tawa_tree",

        replace_mode = mode,
        description = S("Tawa Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:tawa_wood. Creates unilib:tree_tawa_wood
        part_name = "tawa",
        orig_name = "aotearoa:tawa_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Tawa Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:tawa_leaves. Creates unilib:tree_tawa_leaves
        part_name = "tawa",
        orig_name = "aotearoa:tawa_leaves",

        replace_mode = mode,
        description = S("Tawa Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From aotearoa:tawa_leaves
        trunks = {"unilib:tree_tawa_trunk"},
        leaves = {"unilib:tree_tawa_leaves", "unilib:fruit_tawa"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:tawa_sapling. Creates unilib:tree_tawa_sapling
        part_name = "tawa",
        orig_name = "aotearoa:tawa_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Tawa Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_tawa_1", 7, 1, 7},
            {"unilib_tree_tawa_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_tawa_wood. Creates unilib:tree_tawa_wood_fence
        part_name = "tawa",
        orig_name = "aotearoa:fence_tawa_wood",

        replace_mode = mode,
        base_img = "unilib_tree_tawa_wood.png",
        description = S("Tawa Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_tawa_wood_fence_rail
        part_name = "tawa",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_tawa_wood.png",
        description = S("Tawa Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_tawa_wood. Creates unilib:gate_tawa_closed
        part_name = "tawa",
        orig_name = {"aotearoa:gate_tawa_wood_closed", "aotearoa:gate_tawa_wood_open"},

        replace_mode = mode,
        description = S("Tawa Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_tawa_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_tawa_" .. i .. ".mts",

            fill_ratio = 0.0039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration("aotearoa_tree_tawa_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_tawa_" .. i .. ".mts",

            fill_ratio = 0.0078,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration("aotearoa_tree_tawa_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_tawa_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
