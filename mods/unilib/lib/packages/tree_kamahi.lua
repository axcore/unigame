---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_kamahi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_kamahi.init()

    return {
        description = "Kamahi tree",
        optional = "dye_basic",
    }

end

function unilib.pkg.tree_kamahi.exec()

    local burnlevel = 3
    local sci_name = "Weinmannia racemosa"

    unilib.register_tree({
        -- Original to unilib
        part_name = "kamahi",
        description = S("Kamahi Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:kamahi_tree. Creates unilib:tree_kamahi_trunk
        part_name = "kamahi",
        orig_name = "aotearoa:kamahi_tree",

        replace_mode = mode,
        description = S("Kamahi Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kamahi_tree
            type = "cooking",
            output = "unilib:dye_red 4",
            recipe = "unilib:tree_kamahi_trunk",
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:kamahi_wood. Creates unilib:tree_kamahi_wood
        part_name = "kamahi",
        orig_name = "aotearoa:kamahi_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Kamahi Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:kamahi_leaves. Creates unilib:tree_kamahi_leaves
        part_name = "kamahi",
        orig_name = "aotearoa:kamahi_leaves",

        replace_mode = mode,
        description = S("Kamahi Tree Leaves"),
        group_table = {flammable = 2, flower = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("kamahi", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:kamahi_sapling. Creates unilib:tree_kamahi_sapling
        part_name = "kamahi",
        orig_name = "aotearoa:kamahi_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kamahi Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_kamahi_1", 7, 1, 7},
            {"unilib_tree_kamahi_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_kamahi_wood. Creates unilib:tree_kamahi_wood_fence
        part_name = "kamahi",
        orig_name = "aotearoa:fence_kamahi_wood",

        replace_mode = mode,
        base_img = "unilib_tree_kamahi_wood.png",
        description = S("Kamahi Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_kamahi_wood_fence_rail
        part_name = "kamahi",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_kamahi_wood.png",
        description = S("Kamahi Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_kamahi_wood_closed, etc. Creates unilib:gate_kamahi_closed, etc
        part_name = "kamahi",
        orig_name = {"aotearoa:gate_kamahi_wood_closed", "aotearoa:gate_kamahi_wood_open"},

        replace_mode = mode,
        description = S("Kamahi Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_kamahi_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_kamahi_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_tree_kamahi_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_kamahi_" .. i .. ".mts",

            fill_ratio = 0.0117,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
