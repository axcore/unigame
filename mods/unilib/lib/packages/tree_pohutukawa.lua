---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pohutukawa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pohutukawa.init()

    return {
        description = "Pohutukawa tree",
    }

end

function unilib.pkg.tree_pohutukawa.exec()

    local burnlevel = 3
    local sci_name = "Metrosideros excelsa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pohutukawa",
        description = S("Pohutukawa Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:pohutukawa_tree. Creates unilib:tree_pohutukawa_trunk
        part_name = "pohutukawa",
        orig_name = "aotearoa:pohutukawa_tree",

        replace_mode = mode,
        description = S("Pohutukawa Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:pohutukawa_wood. Creates unilib:tree_pohutukawa_wood
        part_name = "pohutukawa",
        orig_name = "aotearoa:pohutukawa_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Pohutukawa Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:pohutukawa_leaves. Creates unilib:tree_pohutukawa_leaves
        part_name = "pohutukawa",
        orig_name = "aotearoa:pohutukawa_leaves",

        replace_mode = mode,
        description = S("Pohutukawa Tree Leaves"),
        group_table = {flammable = 2, flower = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("pohutukawa")

    unilib.register_tree_sapling({
        -- From aotearoa:pohutukawa_sapling. Creates unilib:tree_pohutukawa_sapling
        part_name = "pohutukawa",
        orig_name = "aotearoa:pohutukawa_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Pohutukawa Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_pohutukawa_1", 7, 1, 7},
            {"unilib_tree_pohutukawa_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_pohutukawa_wood. Creates unilib:tree_pohutukawa_wood_fence
        part_name = "pohutukawa",
        orig_name = "aotearoa:fence_pohutukawa_wood",

        replace_mode = mode,
        base_img = "unilib_tree_pohutukawa_wood.png",
        description = S("Pohutukawa Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pohutukawa_wood_fence_rail
        part_name = "pohutukawa",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pohutukawa_wood.png",
        description = S("Pohutukawa Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_pohutukawa_wood_closed, etc. Creates unilib:gate_pohutukawa_closed,
        --      etc
        part_name = "pohutukawa",
        orig_name = {"aotearoa:gate_pohutukawa_wood_closed", "aotearoa:gate_pohutukawa_wood_open"},

        replace_mode = mode,
        description = S("Pohutukawa Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_pohutukawa_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_pohutukawa_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_tree_pohutukawa_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_pohutukawa_" .. i .. ".mts",

            fill_ratio = 0.00195,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
