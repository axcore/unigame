---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_exotic.init()

    return {
        description = "Exotic palm tree",
    }

end

function unilib.pkg.tree_palm_exotic.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_exotic",
        description = S("Exotic Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From farlands, mapgen:palm_tree. Creates unilib:tree_palm_exotic_trunk
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_tree",

        replace_mode = mode,
        description = S("Exotic Palm Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
    })

    unilib.register_tree_wood({
        -- From farlands, mapgen:palm_wood. Creates unilib:tree_palm_exotic_wood
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_wood",

        replace_mode = mode,
        description = S("Exotic Palm Tree Wood Planks"),
        group_table = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From farlands, mapgen:palm_leaves. Creates unilib:tree_palm_exotic_leaves
        part_name = "palm_exotic",
        orig_name = "mapgen:palm_leaves",

        replace_mode = mode,
        description = S("Exotic Palm Tree Leaves"),
        group_table = {flammable = 1, leafdecay = 1, leaves = 1, snappy = 3},
        special_list = {"unilib_tree_palm_exotic_leaves_simple.png"},
    })
    unilib.register_quick_tree_leafdecay("palm_exotic")

    unilib.register_tree_sapling({
        -- From farlands, default:palmtree_sapling. Creates unilib:tree_palm_exotic_sapling
        part_name = "palm_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Palm Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {3, 1, 3},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, mapgen:fence_palm_wood. Creates unilib:tree_palm_exotic_wood_fence
        part_name = "palm_exotic",
        orig_name = "mapgen:fence_palm_wood",

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_palm_exotic_wood.png",
        description = S("Exotic Palm Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_palm_exotic_wood_fence_rail
        part_name = "palm_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_palm_exotic_wood.png",
        description = S("Exotic Palm Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_palm_exotic_closed
        part_name = "palm_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Exotic Palm Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("farlands_tree_palm_exotic_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_palm_exotic.mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.002,
                persist = 0.66,
                scale = 0.001,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            sidelen = 16,
        })

    end

end
