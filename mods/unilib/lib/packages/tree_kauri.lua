---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_kauri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_kauri.init()

    return {
        description = "Kauri tree",
        optional = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.tree_kauri.exec()

    -- (no burnlevel)
    local sci_name = "Agathis australis"

    unilib.register_tree({
        -- Original to unilib
        part_name = "kauri",
        description = S("Kauri Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:kauri_tree. Creates unilib:tree_kauri_trunk
        part_name = "kauri",
        orig_name = "aotearoa:kauri_tree",

        replace_mode = mode,
        description = S("Kauri Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil and
            unilib.pkg_executed_table["torch_ordinary"] ~= nil then

        -- Blue dye from Kauri soot
        unilib.register_craft({
            -- From From aotearoa:kauri_tree
            output = "unilib:dye_blue 4",
            recipe = {
                {"unilib:tree_kauri_trunk"},
                {"unilib:torch_ordinary"},
            },
            replacements = {
                {"unilib:torch_ordinary", "unilib:torch_ordinary"},
            },
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:kauri_wood. Creates unilib:tree_kauri_wood
        part_name = "kauri",
        orig_name = "aotearoa:kauri_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Kauri Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:kauri_leaves. Creates unilib:tree_kauri_leaves
        part_name = "kauri",
        orig_name = "aotearoa:kauri_leaves",

        replace_mode = mode,
        description = S("Kauri Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("kauri", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:kauri_sapling. Creates unilib:tree_kauri_sapling
        part_name = "kauri",
        orig_name = "aotearoa:kauri_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kauri Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_kauri_1", 7, 1, 7},
            {"unilib_tree_kauri_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_kauri_wood. Creates unilib:tree_kauri_wood_fence
        part_name = "kauri",
        orig_name = "aotearoa:fence_kauri_wood",

        replace_mode = mode,
        base_img = "unilib_tree_kauri_wood.png",
        description = S("Kauri Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_kauri_wood_fence_rail
        part_name = "kauri",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_kauri_wood.png",
        description = S("Kauri Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_kauri_wood. Creates unilib:gate_kauri_closed
        part_name = "kauri",
        orig_name = {"aotearoa:gate_kauri_wood_closed", "aotearoa:gate_kauri_wood_open"},

        replace_mode = mode,
        description = S("Kauri Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_kauri_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_kauri_" .. i .. ".mts",

            fill_ratio = 0.0039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
