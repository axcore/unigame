---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_baobab = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_baobab.init()

    return {
        description = "Baobab tree",
    }

end

function unilib.pkg.tree_baobab.exec()

    -- (no burnlevel)
    local sci_name = "Adansonia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "baobab",
        description = S("Baobab Wood"),
    })

    unilib.register_tree_trunk({
        -- From farlands, mapgen:baobab_tree. Creates unilib:tree_baobab_trunk
        part_name = "baobab",
        orig_name = nil,

        replace_mode = mode,
        description = S("Baobab Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From farlands, mapgen:baobab_wood. Creates unilib:tree_baobab_wood
        part_name = "baobab",
        orig_name = "mapgen:baobab_wood",

        replace_mode = mode,
        common_group = 1,
        description = S("Baobab Wood Planks"),
    })

    -- N.B. waving = 2 omitted from the original code
    unilib.register_tree_leaves({
        -- From farlands, mapgen:baobab_leaves. Creates unilib:tree_baobab_leaves
        part_name = "baobab",
        orig_name = "mapgen:baobab_leaves",

        replace_mode = mode,
        description = S("Baobab Tree Leaves"),
        group_table = {flammable = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sci_name = sci_name,
        special_list = {"unilib_tree_baobab_leaves_simple.png"},
    })
    unilib.register_quick_tree_leafdecay("baobab")

    unilib.register_tree_sapling({
        -- From farlands, default:baobab_sapling. Creates unilib:tree_baobab_sapling
        part_name = "baobab",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Baobab Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {8, 1, 8},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, mapgen:fence_baobab. Creates unilib:tree_baobab_wood_fence
        part_name = "baobab",
        orig_name = "mapgen:fence_baobab",

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_baobab_wood.png",
        description = S("Baobab Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_baobab_wood_fence_rail
        part_name = "baobab",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_baobab_wood.png",
        description = S("Baobab Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_baobab_closed
        part_name = "baobab",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Baobab Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("farlands_tree_baobab_1", {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/baobab.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_baobab_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.05,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

    unilib.register_decoration("farlands_tree_baobab_2", {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/baobab1.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_baobab_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.001,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

    unilib.register_decoration("farlands_tree_baobab_3", {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/baobab2.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_baobab_3.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.001,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
