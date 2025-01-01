---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_ipe_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_ipe_yellow.init()

    return {
        description = "Yellow ipê tree",
    }

end

function unilib.pkg.tree_ipe_yellow.exec()

    local burnlevel = 5
    local sci_name = "Handroanthus chrysanthus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "ipe_yellow",
        description = S("Yellow Ipê Wood"),
    })

    unilib.register_tree_trunk({
        -- From farlands, mapgen:yellow_ipe_tree. Creates unilib:tree_ipe_yellow_trunk
        part_name = "ipe_yellow",
        orig_name = "mapgen:yellow_ipe_tree",

        replace_mode = mode,
        description = S("Yellow Ipê Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From farlands, mapgen:yellow_ipe_wood. Creates unilib:tree_ipe_yellow_wood
        part_name = "ipe_yellow",
        orig_name = "mapgen:yellow_ipe_wood",

        replace_mode = mode,
        description = S("Yellow Ipê Wood Planks"),
        group_table = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
    })

    -- N.B. waving = 2 omitted from original code
    unilib.register_tree_leaves({
        -- From farlands, mapgen:yellow_ipe_leaves. Creates unilib:tree_ipe_yellow_leaves
        part_name = "ipe_yellow",
        orig_name = "mapgen:yellow_ipe_leaves",

        replace_mode = mode,
        description = S("Yellow Ipê Tree Leaves"),
        group_table = {flammable = 1, leafdecay = 1, leaves = 1, snappy = 3},
        special_list = {"unilib_tree_ipe_yellow_leaves_simple.png"},
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("ipe_yellow")

    unilib.register_tree_sapling({
        -- From farlands, default:ipe_sapling. Creates unilib:tree_ipe_yellow_sapling
        part_name = "ipe_yellow",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Yellow Ipê Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {7, 1, 6},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, mapgen:fence_yellow_ipe. Creates unilib:tree_ipe_yellow_wood_fence
        part_name = "ipe_yellow",
        orig_name = "mapgen:fence_yellow_ipe",

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_ipe_yellow_wood.png",
        description = S("Yellow Ipê Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_ipe_yellow_wood_fence_rail
        part_name = "ipe_yellow",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_ipe_yellow_wood.png",
        description = S("Yellow Ipê Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_ipe_yellow_closed, etc
        part_name = "ipe_yellow",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Yellow Ipê Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("farlands_tree_ipe_yellow", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_ipe_yellow.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.002,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
