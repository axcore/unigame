---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_kahikatea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_kahikatea.init()

    return {
        description = "Kahikatea tree",
        optional = {"dye_basic", "torch_ordinary"},
    }

end

function unilib.pkg.tree_kahikatea.exec()

    local burnlevel = 2
    local sci_name = "Dacrycarpus dacrydioides"

    unilib.register_tree({
        -- Original to unilib
        part_name = "kahikatea",
        description = S("Kahikatea Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:kahikatea_tree. Creates unilib:tree_kahikatea_trunk
        part_name = "kahikatea",
        orig_name = "aotearoa:kahikatea_tree",

        replace_mode = mode,
        description = S("Kahikatea Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil and
            unilib.global.pkg_executed_table["torch_ordinary"] ~= nil then

        -- Black dye from Kahikatea soot
        unilib.register_craft({
             -- From aotearoa:kahikatea_tree
            output = "unilib:dye_black 4",
            recipe = {
                {"unilib:tree_kahikatea_trunk"},
                {"unilib:torch_ordinary"},
            },
            replacements = {
                {"unilib:torch_ordinary", "unilib:torch_ordinary"},
            },
        })

    end

    unilib.register_tree_wood({
        -- From aotearoa:kahikatea_wood. Creates unilib:tree_kahikatea_wood
        part_name = "kahikatea",
        orig_name = "aotearoa:kahikatea_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Kahikatea Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:kahikatea_leaves. Creates unilib:tree_kahikatea_leaves
        part_name = "kahikatea",
        orig_name = "aotearoa:kahikatea_leaves",

        replace_mode = mode,
        description = S("Kahikatea Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("kahikatea", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:kahikatea_sapling. Creates unilib:tree_kahikatea_sapling
        part_name = "kahikatea",
        orig_name = "aotearoa:kahikatea_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kahikatea Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_kahikatea_1", 7, 1, 7},
            {"unilib_tree_kahikatea_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_kahikatea_wood. Creates unilib:tree_kahikatea_wood_fence
        part_name = "kahikatea",
        orig_name = "aotearoa:fence_kahikatea_wood",

        replace_mode = mode,
        base_img = "unilib_tree_kahikatea_wood.png",
        description = S("Kahikatea Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_kahikatea_wood_fence_rail
        part_name = "kahikatea",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_kahikatea_wood.png",
        description = S("Kahikatea Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_kahikatea_wood_closed, etc. Creates unilib:gate_kahikatea_closed, etc
        part_name = "kahikatea",
        orig_name = {"aotearoa:gate_kahikatea_wood_closed", "aotearoa:gate_kahikatea_wood_open"},

        replace_mode = mode,
        description = S("Kahikatea Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_kahikatea_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_kahikatea_" .. i .. ".mts",

            fill_ratio = 0.0117,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_tree_kahikatea_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_kahikatea_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
