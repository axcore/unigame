---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_kowhai = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_kowhai.init()

    return {
        description = "Kowhai tree",
        optional = "dye_basic",
    }

end

function unilib.pkg.tree_kowhai.exec()

    -- (no burnlevel)
    local sci_name = "Sophora microphylla"

    unilib.register_tree({
        -- Original to unilib
        part_name = "kowhai",
        description = S("Kowhai Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:kowhai_tree. Creates unilib:tree_kowhai_trunk
        part_name = "kowhai",
        orig_name = "aotearoa:kowhai_tree",

        replace_mode = mode,
        description = S("Kowhai Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:kowhai_wood. Creates unilib:tree_kowhai_wood
        part_name = "kowhai",
        orig_name = "aotearoa:kowhai_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Kowhai Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:kowhai_leaves. Creates unilib:tree_kowhai_leaves
        part_name = "kowhai",
        orig_name = "aotearoa:kowhai_leaves",

        replace_mode = mode,
        description = S("Kowhai Tree Leaves"),
        group_table = {flammable = 2, flower = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("kowhai")
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kowhai_leaves
            output = "unilib:dye_yellow 4",
            recipe = {
                {"unilib:tree_kowhai_leaves"},
            },
        })

    end

    unilib.register_tree_sapling({
        -- From aotearoa:kowhai_sapling. Creates unilib:tree_kowhai_sapling
        part_name = "kowhai",
        orig_name = "aotearoa:kowhai_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kowhai Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_kowhai_1", 7, 1, 7},
            {"unilib_tree_kowhai_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_kowhai_wood. Creates unilib:tree_kowhai_wood_fence
        part_name = "kowhai",
        orig_name = "aotearoa:fence_kowhai_wood",

        replace_mode = mode,
        base_img = "unilib_tree_kowhai_wood.png",
        description = S("Kowhai Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_kowhai_wood_fence_rail
        part_name = "kowhai",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_kowhai_wood.png",
        description = S("Kowhai Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_kowhai_wood. Creates unilib:gate_kowhai_closed
        part_name = "kowhai",
        orig_name = {"aotearoa:gate_kowhai_wood_closed", "aotearoa:gate_kowhai_wood_open"},

        replace_mode = mode,
        description = S("Kowhai Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_kowhai_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_kowhai_" .. i .. ".mts",

            fill_ratio = 0.0078,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
