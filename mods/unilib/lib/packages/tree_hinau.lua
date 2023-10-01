---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_hinau = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_hinau.init()

    return {
        description = "Hinau tree",
        notes = "Produces hinau fruit",
        depends = "fruit_hinau",
        optional = "dye_basic",
    }

end

function unilib.pkg.tree_hinau.exec()

    -- (no burnlevel)
    local sci_name = "Elaeocarpus dentatus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "hinau",
        description = S("Hinau Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:hinau_tree. Creates unilib:tree_hinau_trunk
        part_name = "hinau",
        orig_name = "aotearoa:hinau_tree",

        replace_mode = mode,
        description = S("Hinau Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        minetest.register_craft({
             -- From aotearoa:hinau_tree
            type = "cooking",
            output = "unilib:dye_black 4",
            recipe = "unilib:tree_hinau_trunk",
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:hinau_wood. Creates unilib:tree_hinau_wood
        part_name = "hinau",
        orig_name = "aotearoa:hinau_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Hinau Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:hinau_leaves. Creates unilib:tree_hinau_leaves
        part_name = "hinau",
        orig_name = "aotearoa:hinau_leaves",

        replace_mode = mode,
        description = S("Hinau Tree Leaves"),
        group_table = {flammable = 2, flower = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From aotearoa:hinau_leaves
        trunks = {"unilib:tree_hinau_trunk"},
        leaves = {"unilib:tree_hinau_leaves", "unilib:fruit_hinau"},
        radius = 2,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:hinau_sapling. Creates unilib:tree_hinau_sapling
        part_name = "hinau",
        orig_name = "aotearoa:hinau_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Hinau Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_hinau_1", 7, 1, 7},
            {"unilib_tree_hinau_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_hinau_wood. Creates unilib:tree_hinau_wood_fence
        part_name = "hinau",
        orig_name = "aotearoa:fence_hinau_wood",

        replace_mode = mode,
        base_img = "unilib_tree_hinau_wood.png",
        description = S("Hinau Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_hinau_wood_fence_rail
        part_name = "hinau",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_hinau_wood.png",
        description = S("Hinau Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_hinau_wood. Creates unilib:gate_hinau_closed
        part_name = "hinau",
        orig_name = {"aotearoa:gate_hinau_wood_closed", "aotearoa:gate_hinau_wood_open"},

        replace_mode = mode,
        description = S("Hinau Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_hinau_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_hinau_" .. i .. ".mts",

            fill_ratio = 0.0078,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration("aotearoa_tree_hinau_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_hinau_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
