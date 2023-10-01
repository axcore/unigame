---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jungle_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle_exotic.init()

    return {
        description = "Exotic jungle tree",
        notes = "This package was created because the minetest_game and farlands versions of the" ..
                " five basic trees had similar (but not identical) textures; the farlands trees" ..
                " are therefore named \"exotic\"",
        optional = {"mushroom_brown", "vine_jungle"},
    }

end

function unilib.pkg.tree_jungle_exotic.exec()

    -- (Using same level as the equivalent tree in default)
    local burnlevel = 5
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "jungle_exotic",
        description = S("Exotic Jungle Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From farlands, default:jungletree. Creates unilib:tree_jungle_exotic_trunk
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Jungle Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From farlands, default:junglewood. Creates unilib:tree_jungle_exotic_wood
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Jungle Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From farlands, default:jungleleaves. Creates unilib:tree_jungle_exotic_leaves
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Jungle Tree Leaves"),
        special_list = {"unilib_tree_jungle_exotic_leaves_simple.png"},
    })
    unilib.register_quick_tree_leafdecay("jungle_exotic", 2)

    unilib.register_tree_sapling({
        -- From farlands, default:junglesapling. Creates unilib:tree_jungle_exotic_sapling
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Jungle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, default:fence_junglewood. Creates unilib:tree_jungle_exotic_wood_fence
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it doesn't match the colour of the wood
        base_img = "unilib_tree_jungle_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Jungle Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_jungle_exotic_wood_fence_rail
        part_name = "jungle_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_jungle_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Jungle Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_junglewood. Creates unilib:gate_jungle_exotic_closed
        part_name = "jungle_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Jungle Tree Wood Fence Gate"),
        -- N.B. door = 1 omitted from the original code
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    -- N.B. This schematic includes vines
    if unilib.pkg_executed_table["vine_jungle"] ~= nil then

        unilib.register_decoration("farlands_tree_jungle_exotic_1", {
            -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/jungletree.mts
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_jungle_exotic_1.mts",

            fill_ratio = 0.03,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

    unilib.register_decoration("farlands_tree_jungle_exotic_2", {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/jungle_tree.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_jungle_exotic_2.mts",

        fill_ratio = 0.03,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

    unilib.register_decoration("farlands_tree_jungle_exotic_3", {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/junglepalm.mts
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_jungle_exotic_3.mts",

        fill_ratio = 0.03,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

    if unilib.pkg_executed_table["mushroom_brown"] ~= nil then

        unilib.register_decoration("farlands_tree_jungle_exotic_log", {
            -- From farlands, mapgen/mapgen.lua (schematic in code)
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_jungle_exotic_log.mts",

            fill_ratio = 0.005,
            flags = "place_center_x",
            rotation = "random",
            sidelen = 80,
        })

    end

end
