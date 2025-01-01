---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_rimu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_rimu.init()

    return {
        description = "Rimu tree",
        optional = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.tree_rimu.exec()

    local burnlevel = 3
    local sci_name = "Dacrydium cupressinum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "rimu",
        description = S("Rimu Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:rimu_tree. Creates unilib:tree_rimu_trunk
        part_name = "rimu",
        orig_name = "aotearoa:rimu_tree",

        replace_mode = mode,
        description = S("Rimu Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil and
            unilib.global.pkg_executed_table["torch_ordinary"] ~= nil then

        -- Blue dye from Rimu soot
        unilib.register_craft({
            -- From From aotearoa:rimu_tree
            output = "unilib:dye_blue 4",
            recipe = {
                {"unilib:tree_rimu_trunk"},
                {"unilib:torch_ordinary"},
            },
            replacements = {
                {"unilib:torch_ordinary", "unilib:torch_ordinary"},
            },
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:rimu_wood. Creates unilib:tree_rimu_wood
        part_name = "rimu",
        orig_name = "aotearoa:rimu_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Rimu Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:rimu_leaves. Creates unilib:tree_rimu_leaves
        part_name = "rimu",
        orig_name = "aotearoa:rimu_leaves",

        replace_mode = mode,
        description = S("Rimu Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("rimu")

    unilib.register_tree_sapling({
        -- From aotearoa:rimu_sapling. Creates unilib:tree_rimu_sapling
        part_name = "rimu",
        orig_name = "aotearoa:rimu_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Rimu Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_rimu_1", 7, 1, 7},
            {"unilib_tree_rimu_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_rimu_wood. Creates unilib:tree_rimu_wood_fence
        part_name = "rimu",
        orig_name = "aotearoa:fence_rimu_wood",

        replace_mode = mode,
        base_img = "unilib_tree_rimu_wood.png",
        description = S("Rimu Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_rimu_wood_fence_rail
        part_name = "rimu",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_rimu_wood.png",
        description = S("Rimu Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_rimu_wood_closed, etc. Creates unilib:gate_rimu_closed, etc
        part_name = "rimu",
        orig_name = {"aotearoa:gate_rimu_wood_closed", "aotearoa:gate_rimu_wood_open"},

        replace_mode = mode,
        description = S("Rimu Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_rimu_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_rimu_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_tree_rimu_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_rimu_" .. i .. ".mts",

            fill_ratio = 0.0117,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
