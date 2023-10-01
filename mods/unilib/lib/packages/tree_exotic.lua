---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_exotic.init()

    return {
        description = "Exotic tree",
        notes = "In farlands/mapgen, there are schematics for both \"deciduous\" and \"oak\"" ..
                " trees, both using \"default\" tree nodes. Those nodes are described as" ..
                " \"oak\"; in unilib, they are imported as a new type of exotic tree, using" ..
                " all five schematics",
    }

end

function unilib.pkg.tree_exotic.exec()

    -- (Using same level as the equivalent tree in default)
    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "exotic",
        description = S("Exotic Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From farlands, default:tree. Creates unilib:tree_exotic_trunk
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From farlands, default:wood. Creates unilib:tree_exotic_wood
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From farlands, default:leaves. Creates unilib:tree_exotic_leaves
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Tree Leaves"),
        special_list = {"unilib_tree_exotic_leaves_simple.png"},
    })
    unilib.register_quick_tree_leafdecay("exotic")

    unilib.register_tree_sapling({
        -- From farlands, default:sapling. Creates unilib:tree_exotic_sapling
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
            snappy = 2,
        },
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, default:fence_wood. Creates unilib:tree_exotic_wood_fence
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_exotic_wood_fence_rail
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_wood. Creates unilib:gate_exotic_closed
        part_name = "exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Tree Wood Fence Gate"),
        -- N.B. door = 1 omitted from the original code
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    -- N.B. Adapted from the "deciduous" schematics
    for i = 1, 3 do

        unilib.register_decoration("farlands_tree_exotic_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_exotic_" .. i .. ".mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.016,
                persist = 0.66,
                scale = 0.012,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            sidelen = 16,
        })

    end

    -- N.B. Adapted from the "oak" schematics
    unilib.register_decoration("farlands_tree_exotic_4", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_exotic_4.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.015,
            persist = 0.66,
            scale = 0.005,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    unilib.register_decoration("farlands_tree_exotic_5", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_exotic_5.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.025,
            persist = 0.66,
            scale = 0.010,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
