---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_totara = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_totara.init()

    return {
        description = "Totara tree",
    }

end

function unilib.pkg.tree_totara.exec()

    local burnlevel = 4
    local sci_name = "Podocarpus totara"

    unilib.register_tree({
        -- Original to unilib
        part_name = "totara",
        description = S("Totara Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:totara_tree. Creates unilib:tree_totara_trunk
        part_name = "totara",
        orig_name = "aotearoa:totara_tree",

        replace_mode = mode,
        description = S("Totara Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:totara_wood. Creates unilib:tree_totara_wood
        part_name = "totara",
        orig_name = "aotearoa:totara_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Totara Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:totara_leaves. Creates unilib:tree_totara_leaves
        part_name = "totara",
        orig_name = "aotearoa:totara_leaves",

        replace_mode = mode,
        description = S("Totara Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("totara", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:totara_sapling. Creates unilib:tree_totara_sapling
        part_name = "totara",
        orig_name = "aotearoa:totara_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Totara Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_totara_1", 7, 1, 7},
            {"unilib_tree_totara_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_totara_wood. Creates unilib:tree_totara_wood_fence
        part_name = "totara",
        orig_name = "aotearoa:fence_totara_wood",

        replace_mode = mode,
        base_img = "unilib_tree_totara_wood.png",
        description = S("Totara Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_totara_wood_fence_rail
        part_name = "totara",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_totara_wood.png",
        description = S("Totara Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_totara_wood_closed, etc. Creates unilib:gate_totara_closed, etc
        part_name = "totara",
        orig_name = {"aotearoa:gate_totara_wood_closed", "aotearoa:gate_totara_wood_open"},

        replace_mode = mode,
        description = S("Totara Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_totara_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_totara_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

        unilib.register_decoration_generic("aotearoa_tree_totara_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_totara_" .. i .. ".mts",

            fill_ratio = 0.0117,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
