---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_karaka = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_karaka.init()

    return {
        description = "Karaka tree",
        notes = "Produces karaka fruit",
        depends = "fruit_karaka",
    }

end

function unilib.pkg.tree_karaka.exec()

    -- (no burnlevel)
    local sci_name = "Corynocarpus laevigatus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "karaka",
        description = S("Karaka Wood"),
    })

    unilib.register_tree_trunk({
        -- From aotearoa:karaka_tree. Creates unilib:tree_karaka_trunk
        part_name = "karaka",
        orig_name = "aotearoa:karaka_tree",

        replace_mode = mode,
        description = S("Karaka Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From aotearoa:karaka_wood. Creates unilib:tree_karaka_wood
        part_name = "karaka",
        orig_name = "aotearoa:karaka_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Karaka Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From aotearoa:karaka_leaves. Creates unilib:tree_karaka_leaves
        part_name = "karaka",
        orig_name = "aotearoa:karaka_leaves",

        replace_mode = mode,
        description = S("Karaka Tree Leaves"),
        group_table = {flammable = 2, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 50,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From aotearoa:karaka_leaves
        trunks = {"unilib:tree_karaka_trunk"},
        leaves = {"unilib:tree_karaka_leaves", "unilib:fruit_karaka"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:karaka_sapling. Creates unilib:tree_karaka_sapling
        part_name = "karaka",
        orig_name = "aotearoa:karaka_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Karaka Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_karaka_1", 7, 1, 7},
            {"unilib_tree_karaka_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From aotearoa:fence_karaka_wood. Creates unilib:tree_karaka_wood_fence
        part_name = "karaka",
        orig_name = "aotearoa:fence_karaka_wood",

        replace_mode = mode,
        base_img = "unilib_tree_karaka_wood.png",
        description = S("Karaka Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_karaka_wood_fence_rail
        part_name = "karaka",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_karaka_wood.png",
        description = S("Karaka Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    unilib.register_fence_gate_quick({
        -- From aotearoa:gate_karaka_wood. Creates unilib:gate_karaka_closed
        part_name = "karaka",
        orig_name = {"aotearoa:gate_karaka_wood_closed", "aotearoa:gate_karaka_wood_open"},

        replace_mode = mode,
        description = S("Karaka Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_karaka_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_karaka_" .. i .. ".mts",

            fill_ratio = 0.00039,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end
    unilib.register_decoration("aotearoa_tree_karaka_grove_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_karaka_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.004,
            seed = 45254,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_karaka_grove_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_karaka_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.004,
            seed = 108761,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })

end
