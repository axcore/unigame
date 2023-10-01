---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_exotic.init()

    return {
        description = "Exotic pine tree",
        notes = "This package was created because the minetest_game and farlands versions of the" ..
                " five basic trees had similar (but not identical) textures; the farlands trees" ..
                " are therefore named \"exotic\"",
        optional = "mushroom_red",
    }

end

function unilib.pkg.tree_pine_exotic.exec()

    -- (Using same level as the equivalent tree in default)
    local burnlevel = 2
    local sci_name = "Pinus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_exotic",
        description = S("Exotic Pine Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From farlands, default:pine_tree. Creates unilib:tree_pine_exotic_trunk
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Pine Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From farlands, default:pine_wood. Creates unilib:tree_pine_exotic_wood
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Pine Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From farlands, default:pine_needles. Creates unilib:tree_pine_exotic_leaves
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Pine Tree Needles"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("pine_exotic", 2)

    -- (Grows trees using the schematic from farlands/default)
    unilib.register_tree_sapling({
        -- From farlands, default:pine_sapling. Creates unilib:tree_pine_exotic_sapling
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 3,
        description = S("Exotic Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 12, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
--      offset_list = {2, 1, 2},
        schem_list = {
            {"unilib_tree_pine_exotic_1", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    -- (Grows trees using the schematic from farlands/mapgen)
    unilib.register_tree_sapling({
        -- From farlands, farlands, default:big_pine_sapling. Creates
        --      unilib:tree_pine_exotic_sapling_big
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Big Exotic Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
--      offset_list = {3, 1, 3},
        schem_list = {
            {"unilib_tree_pine_exotic_2", 3, 1, 3},
        },
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        variant_name = "big",
    })

    unilib.register_fence_quick({
        -- From farlands, default:fence_pine_wood. Creates unilib:tree_pine_exotic_wood_fence
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_pine_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Pine Wood Fence"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pine_exotic_wood_fence_rail
        part_name = "pine_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pine_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Pine Wood Fence Rail"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_pine_wood. Creates unilib:gate_pine_exotic_closed
        part_name = "pine_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Pine Wood Fence Gate"),
        -- N.B. door = 1 in original code, omitted here
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("farlands_tree_pine_exotic_1", {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/pine_tree.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pine_exotic_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.036,
            persist = 0.66,
            scale = 0.022,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    unilib.register_decoration("farlands_tree_pine_exotic_2", {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/pine_tree.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pine_exotic_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.006,
            persist = 0.66,
            scale = 0.002,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    -- N.B. During schematic conversion, removed condensed meat
    unilib.register_decoration("farlands_tree_pine_exotic_3", {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/pine.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pine_exotic_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            offset = 0.036,
            scale = 0.022,
            spread = {x = 250, y = 250, z = 250},
            seed = 2,
            octaves = 3,
            persist = 0.66
        },
        sidelen = 16,
    })

    if unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_decoration("farlands_tree_pine_exotic_log", {
            -- From farlands, mapgen/mapgen.lua (schematic in code)
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_exotic_log.mts",

            flags = "place_center_x",
            noise_params = {
                octaves = 3,
                offset = 0.0018,
                persist = 0.66,
                scale = 0.0011,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            rotation = "random",
            sidelen = 80,
        })

    end

end
