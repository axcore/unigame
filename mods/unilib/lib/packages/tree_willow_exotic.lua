---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_willow_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_willow_exotic.init()

    return {
        description = "Exotic willow tree",
    }

end

function unilib.pkg.tree_willow_exotic.exec()

    -- (no burnlevel)
    local sci_name = "Salix"

    unilib.register_tree({
        -- Original to unilib
        part_name = "willow_exotic",
        description = S("Exotic Willow Wood"),
    })

    unilib.register_tree_trunk({
        -- From farlands, mapgen:willow_tree. Creates unilib:tree_willow_exotic_trunk
        part_name = "willow_exotic",
        orig_name = "mapgen:willow_tree",

        replace_mode = mode,
        description = S("Exotic Willow Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From farlands, mapgen:willow_wood. Creates unilib:tree_willow_exotic_wood
        part_name = "willow_exotic",
        orig_name = "mapgen:willow_wood",

        replace_mode = mode,
        description = S("Exotic Willow Wood Planks"),
        group_table = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From farlands, mapgen:willow_leaves. Creates unilib:tree_willow_exotic_leaves
        part_name = "willow_exotic",
        orig_name = "mapgen:willow_leaves",

        replace_mode = mode,
        description = S("Exotic Willow Tree Leaves"),
        group_table = {flammable = 1, leafdecay = 1, leaves = 1, snappy = 3},
        sci_name = sci_name,
        special_list = {"unilib_tree_willow_exotic_leaves_simple.png"},
    })
    unilib.register_quick_tree_leafdecay("willow_exotic")

    unilib.register_tree_sapling({
        -- From farlands, default:willow_sapling. Creates unilib:tree_willow_exotic_sapling
        part_name = "willow_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Willow Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        schem_list = {
            {"unilib_tree_willow_exotic_1", 3, 0, 3},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_all({
        -- Original to unilib
        part_name = "willow_exotic",

        replace_mode = mode,
        fence_description = S("Exotic Willow Wood Fence"),
        gate_description = S("Exotic Willow Wood Fence Rail"),
        rail_description = S("Exotic Willow Wood Fence Gate"),
    })

    -- N.B. schematic #1 commented out in original code, but included here
    unilib.register_decoration("farlands_tree_willow_exotic_1", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_willow_exotic_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.0,
            persist = 0.66,
            scale = -0.015,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    unilib.register_decoration("farlands_tree_willow_exotic_2", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_willow_exotic_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.01,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
