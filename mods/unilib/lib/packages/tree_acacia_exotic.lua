---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_acacia_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_acacia_exotic.init()

    return {
        description = "Exotic acacia tree",
        notes = "This package was created because the minetest_game and farlands versions of the" ..
                " five basic trees had similar (but not identical) textures; the farlands trees" ..
                " are therefore named \"exotic\"",
        depends = "fruit_orange_exotic",
        optional = {
            -- If the "ore_farlands_tree_acacia_exotic" package is not loaded, then the shared
            --      package will use an ABM to place leaves-with-fruit nodes instead
            "abm_farlands_bushes_trees",
            -- Create fruit-as-node variants for use in schematics
            "shared_farlands_fruit",
        },
    }

end

function unilib.pkg.tree_acacia_exotic.exec()

    -- N.B. throughout this package, original node names are ignored when they use a mod name (e.g.
    --      default, doors) that's also used by minetest_game

    -- (Using same level as the equivalent tree in default)
    local burnlevel = 4
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "acacia_exotic",
        description = S("Exotic Acacia Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From farlands, default:acacia_tree. Creates unilib:tree_acacia_exotic_trunk
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Acacia Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From farlands, default:acacia_wood. Creates unilib:tree_acacia_exotic_wood
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Acacia Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From farlands, default:acacia_leaves. Creates unilib:tree_acacia_exotic_leaves
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Acacia Tree Leaves"),
        special_list = {"unilib_tree_acacia_exotic_leaves_simple.png"},
    })
    -- (unilib.register_leafdecay() occurs below)

    unilib.register_node(
        -- From farlands, fruit:leaves_with_orange
        "unilib:tree_acacia_exotic_leaves_with_orange",
        "fruit:leaves_with_orange",
        mode,
        {
            description = S("Exotic Acacia Leaves with Oranges"),
            tiles = {"unilib_tree_acacia_exotic_leaves.png^unilib_fruit_orange_exotic_overlay.png"},
            groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = "unilib:tree_acacia_exotic_leaves",
            -- N.B. is_ground_content = false not in original code; added to match other leaves
            is_ground_content = false,
            paramtype = "light",
            special_tiles = {
                "unilib_tree_acacia_exotic_leaves_simple.png^unilib_fruit_orange_exotic_overlay.png"
            },
            waving = 1,

            on_destruct = function(pos)
                core.add_item(pos, "unilib:fruit_orange_exotic")
            end,

            on_rightclick = function(pos)
                core.set_node(pos, {name = "unilib:tree_acacia_exotic_leaves"})
            end,
        }
    )

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        -- Create the fruit-as-node variant for use in schematics, unilib:fruit_orange_exotic_node
        unilib.pkg.shared_farlands_fruit.create_fruit_nodes("orange", "food_orange")

    end

    unilib.register_leafdecay({
        -- From farlands, default:acacia_leaves
        trunk_type = "acacia_exotic",
        trunks = {"unilib:tree_acacia_exotic_trunk"},
        leaves = {
            "unilib:tree_acacia_exotic_leaves",
            "unilib:tree_acacia_exotic_leaves_with_orange",
        },
        -- N.B. required if the "shared_farlands_fruit" package is loaded
        others = {"unilib:fruit_orange_exotic_node"},
        radius = 2,
    })

    unilib.register_tree_sapling({
        -- From farlands, default:acacia_sapling. Creates unilib:tree_acacia_exotic_sapling
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Exotic Acacia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 6, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 1, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From farlands, default:fence_acacia_wood. Creates unilib:tree_acacia_exotic_wood_fence
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        -- N.B. farlands provides a separate texture, but it's identical to the wood
        base_img = "unilib_tree_acacia_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Acacia Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_acacia_exotic_wood_fence_rail
        part_name = "acacia_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_acacia_exotic_wood.png",
        burnlevel = burnlevel,
        description = S("Exotic Acacia Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_acacia_wood. Creates unilib:gate_acacia_exotic_closed
        part_name = "acacia_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Exotic Acacia Wood Fence Gate"),
        -- N.B. door = 1 in original code, omitted here
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("farlands_tree_acacia_exotic", {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/acacia_tree.mts
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_acacia_exotic.mts",

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

    unilib.register_decoration_generic("farlands_tree_acacia_exotic_log", {
        -- From farlands, mapgen/mapgen.lua (schematic in code)
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_acacia_exotic_log.mts",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end

function unilib.pkg.tree_acacia_exotic.post()

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        unilib.register_regrowing_fruit({
            fruit_name = "unilib:fruit_orange_exotic_node",

            replace_mode = mode,
            leaves_list = {"unilib:tree_acacia_exotic_leaves"},
            pkg_list = {"tree_acacia_exotic"},
        })

    end

end
