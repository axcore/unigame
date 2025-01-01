---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

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
        optional = {
            -- If the "ore_farlands_tree_exotic" package is not loaded, then the shared package will
            --      use an ABM to place leaves-with-fruit nodes instead
            "abm_farlands_bushes_trees",
            -- Create fruit-as-node variants for use in schematics
            "shared_farlands_fruit",
        },
        at_least_one = {
            "fruit_apple_exotic",
            "fruit_peach_exotic",
            "fruit_pear_exotic",
            "fruit_plum_exotic",
        },
    }

end

function unilib.pkg.tree_exotic.exec()

    -- N.B. throughout this package, original node names are ignored when they use a mod name (e.g.
    --      default, doors) that's also used by minetest_game

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
    -- (unilib.register_leafdecay() occurs below)

    if unilib.global.pkg_executed_table["fruit_apple_exotic"] ~= nil then

        unilib.register_node("unilib:tree_exotic_leaves_with_apple", nil, mode, {
            -- From farlands, default:apple
            description = S("Exotic Tree Leaves with Apples"),
            tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_apple_exotic_overlay.png"},
            groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = "unilib:tree_exotic_leaves",
            -- N.B. is_ground_content = false not in original code; added to match other leaves
            is_ground_content = false,
            paramtype = "light",
            special_tiles = {
                "unilib_tree_exotic_leaves_simple.png^unilib_fruit_apple_exotic_overlay.png",
            },
            waving = 1,

            on_destruct = function(pos)
                core.add_item(pos, "unilib:fruit_apple_exotic")
            end,

            on_rightclick = function(pos)
                core.set_node(pos, {name = "unilib:tree_exotic_leaves"})
            end,
        })

        -- N.B. No need to call  unilib.pkg.shared_farlands_fruit.create_fruit_nodes(), as
        --      unilib:fruit_apple_exotic is already a node)

    end

    if unilib.global.pkg_executed_table["fruit_peach_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_peach
            "unilib:tree_exotic_leaves_with_peach",
            "fruit:leaves_with_peach",
            mode,
            {
                description = S("Exotic Tree Leaves with Peaches"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_peach_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.global.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                -- N.B. is_ground_content = false not in original code; added to match other leaves
                is_ground_content = false,
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_peach_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    core.add_item(pos, "unilib:fruit_peach_exotic")
                end,

                on_rightclick = function(pos)
                    core.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

        if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

            -- Create the fruit-as-node variant for use in schematics,
            --      unilib:fruit_peach_exotic_node
            unilib.pkg.shared_farlands_fruit.create_fruit_nodes("peach", "food_peach")

        end

    end

    if unilib.global.pkg_executed_table["fruit_pear_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_pear
            "unilib:tree_exotic_leaves_with_pear",
            "fruit:leaves_with_pear",
            mode,
            {
                description = S("Exotic Tree Leaves with Pears"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_pear_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.global.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                -- N.B. is_ground_content = false not in original code; added to match other leaves
                is_ground_content = false,
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_pear_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    core.add_item(pos, "unilib:fruit_pear_exotic")
                end,

                on_rightclick = function(pos)
                    core.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

        if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

            -- Create the fruit-as-node variant for use in schematics, unilib:fruit_pear_exotic_node
            unilib.pkg.shared_farlands_fruit.create_fruit_nodes("pear", "food_pear")

        end

    end

    if unilib.global.pkg_executed_table["fruit_plum_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_plum
            "unilib:tree_exotic_leaves_with_plum",
            "fruit:leaves_with_plum",
            mode,
            {
                description = S("Exotic Tree Leaves with Plums"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_plum_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.global.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                -- N.B. is_ground_content = false not in original code; added to match other leaves
                is_ground_content = false,
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_plum_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    core.add_item(pos, "unilib:fruit_plum_exotic")
                end,

                on_rightclick = function(pos)
                    core.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

        if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

            -- Create the fruit-as-node variant for use in schematics, unilib:fruit_plum_exotic_node
            unilib.pkg.shared_farlands_fruit.create_fruit_nodes("plum", "food_plum")

        end

    end

    unilib.register_leafdecay({
        -- From farlands, default:leaves
        trunk_type = "exotic",
        trunks = {"unilib:tree_exotic_trunk"},
        leaves = {
            "unilib:tree_exotic_leaves",
            "unilib:tree_exotic_leaves_with_apple",
            "unilib:tree_exotic_leaves_with_peach",
            "unilib:tree_exotic_leaves_with_pear",
            "unilib:tree_exotic_leaves_with_plum",
        },
        -- N.B. required if the "shared_farlands_fruit" package is loaded
        others = {
            "unilib:fruit_apple_exotic",
            "unilib:fruit_peach_exotic_node",
            "unilib:fruit_pear_exotic_node",
            "unilib:fruit_plum_exotic_node",
        },
        radius = 3,
    })

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
        schem_list = {
            {"unilib_tree_exotic_1", 3, 1, 2},
            {"unilib_tree_exotic_2", 4, 1, 3},
            {"unilib_tree_exotic_3", 2, 1, 2},
            {"unilib_tree_exotic_4", 3, 1, 3},
            {"unilib_tree_exotic_5", 2, 1, 2},
        },
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

        unilib.register_decoration_generic("farlands_tree_exotic_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_exotic_" .. i .. ".mts",

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
    unilib.register_decoration_generic("farlands_tree_exotic_4", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_exotic_4.mts",

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

    unilib.register_decoration_generic("farlands_tree_exotic_5", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_exotic_5.mts",

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

function unilib.pkg.tree_exotic.post()

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        -- N.B. No need to call unilib.register_regrowing_fruit() for unilib:fruit_apple_exotic, as
        --      it is already a node)

        if unilib.global.pkg_executed_table["fruit_peach_exotic"] ~= nil then

            unilib.register_regrowing_fruit({
                fruit_name = "unilib:fruit_peach_exotic_node",

                replace_mode = mode,
                leaves_list = {"unilib:tree_exotic_leaves"},
                pkg_list = {"tree_exotic"},
            })

        end

        if unilib.global.pkg_executed_table["fruit_pear_exotic"] ~= nil then

            unilib.register_regrowing_fruit({
                fruit_name = "unilib:fruit_pear_exotic_node",

                replace_mode = mode,
                leaves_list = {"unilib:tree_exotic_leaves"},
                pkg_list = {"tree_exotic"},
            })

        end

        if unilib.global.pkg_executed_table["fruit_plum_exotic"] ~= nil then

            unilib.register_regrowing_fruit({
                fruit_name = "unilib:fruit_plum_exotic_node",

                replace_mode = mode,
                leaves_list = {"unilib:tree_exotic_leaves"},
                pkg_list = {"tree_exotic"},
            })

        end

    end

end
