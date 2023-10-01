---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_oak_graveyard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grave.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_oak_graveyard.init()

    return {
        description = "Graveyard oak tree",
    }

end

function unilib.pkg.tree_oak_graveyard.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "oak_graveyard",
        description = S("Graveyard Oak Wood"),
    })

    unilib.register_tree_trunk({
        -- From grave:grave_oak_tree. Creates unilib:tree_oak_graveyard_trunk
        part_name = "oak_graveyard",
        orig_name = "grave:grave_oak_tree",

        replace_mode = mode,
        common_group = 2,
        description = S("Graveyard Oak Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From grave:grave_oak_wood. Creates unilib:tree_oak_graveyard_wood
        part_name = "oak_graveyard",
        orig_name = "grave:grave_oak_wood",

        replace_mode = mode,
        common_group = 2,
        description = S("Graveyard Oak Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From dgrave:grave_oak_leaves. Creates unilib:tree_oak_graveyard_leaves
        part_name = "oak_graveyard",
        orig_name = "grave:grave_oak_leaves",

        replace_mode = mode,
        description = S("Graveyard Oak Tree Leaves"),
    })
    unilib.register_quick_tree_leafdecay("oak_graveyard")

    unilib.register_tree_sapling({
        -- From grave:grave_oak_sapling. Creates unilib:tree_oak_graveyard_sapling
        part_name = "oak_graveyard",
        orig_name = "grave:grave_oak_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Graveyard Oak Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        offset_list = {3, 1, 3},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From grave:fence_grave_oak_wood. Creates unilib:tree_oak_graveyard_wood_fence
        part_name = "oak_graveyard",
        orig_name = "grave:fence_grave_oak_wood",

        replace_mode = mode,
        description = S("Graveyard Oak Wood Fence"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From grave:fence_rail_grave_oak_wood. Creates unilib:tree_oak_graveyard_wood_fence_rail
        part_name = "oak_graveyard",
        orig_name = "grave:fence_rail_grave_oak_wood",

        replace_mode = mode,
        description = S("Graveyard Oak Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_oak_graveyard_closed
        part_name = "oak_graveyard",
        orig_name = nil,

        replace_mode = mode,
        description = S("Graveyard Oak Wood Fence Gate"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("grave_tree_oak_graveyard", {
        -- From grave/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_oak_graveyard.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.010,
            persist = 0.66,
            scale = -0.048,
            seed = 2,
            spread = {x = 50, y = 50, z = 50},
        },
        rotation = "random",
        sidelen = 80,
    })

end
