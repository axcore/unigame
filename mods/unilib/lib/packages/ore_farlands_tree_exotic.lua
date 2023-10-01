---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_tree_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_tree_exotic.init()

    return {
        description = "Exotic tree leaves with fruit, implemented as an ore",
        depends = "tree_exotic",
        at_least_one = {
            "fruit_apple_exotic",
            "fruit_peach_exotic",
            "fruit_pear_exotic",
            "fruit_plum_exotic",
        },
    }

end

function unilib.pkg.ore_farlands_tree_exotic.exec()

    if unilib.pkg_executed_table["fruit_apple_exotic"] ~= nil then

        unilib.register_node("unilib:tree_exotic_leaves_with_apple", nil, mode, {
            -- From farlands, default:apple
            description = S("Exotic Tree Leaves with Apples"),
            tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_apple_exotic_overlay.png"},
            groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = "unilib:tree_exotic_leaves",
            paramtype = "light",
            special_tiles = {
                "unilib_tree_exotic_leaves_simple.png^unilib_fruit_apple_exotic_overlay.png",
            },
            waving = 1,

            on_destruct = function(pos)
                minetest.add_item(pos, "unilib:fruit_apple_exotic")
            end,

            on_rightclick = function(pos)
                minetest.set_node(pos, {name = "unilib:tree_exotic_leaves"})
            end,
        })

    end

    if unilib.pkg_executed_table["fruit_peach_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_peach
            "unilib:tree_exotic_leaves_with_peach",
            "fruit:leaves_with_peach",
            mode,
            {
                description = S("Exotic Tree Leaves with Peaches"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_peach_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_peach_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    minetest.add_item(pos, "unilib:fruit_peach_exotic")
                end,

                on_rightclick = function(pos)
                    minetest.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

    end

    if unilib.pkg_executed_table["fruit_pear_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_pear
            "unilib:tree_exotic_leaves_with_pear",
            "fruit:leaves_with_pear",
            mode,
            {
                description = S("Exotic Tree Leaves with Pears"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_pear_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_pear_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    minetest.add_item(pos, "unilib:fruit_pear_exotic")
                end,

                on_rightclick = function(pos)
                    minetest.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

    end

    if unilib.pkg_executed_table["fruit_plum_exotic"] ~= nil then

        unilib.register_node(
            -- From farlands, fruit:leaves_with_plum
            "unilib:tree_exotic_leaves_with_plum",
            "fruit:leaves_with_plum",
            mode,
            {
                description = S("Exotic Tree Leaves with Plums"),
                tiles = {"unilib_tree_exotic_leaves.png^unilib_fruit_plum_exotic_overlay.png"},
                groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.sound_table.leaves,

                drawtype = "allfaces_optional",
                drop = "unilib:tree_exotic_leaves",
                paramtype = "light",
                special_tiles = {
                    "unilib_tree_exotic_leaves_simple.png^unilib_fruit_plum_exotic_overlay.png",
                },
                waving = 1,

                on_destruct = function(pos)
                    minetest.add_item(pos, "unilib:fruit_plum_exotic")
                end,

                on_rightclick = function(pos)
                    minetest.set_node(pos, {name = "unilib:tree_exotic_leaves"})
                end,
            }
        )

    end

end

function unilib.pkg.ore_farlands_tree_exotic.post()

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_exotic_leaves_with_apple",
        wherein                 = "unilib:tree_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 4,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 1,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = unilib.y_max,
        y_min                   = 0,
    })

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_exotic_leaves_with_peach",
        wherein                 = "unilib:tree_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 4,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 1,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = unilib.y_max,
        y_min                   = 0,
    })

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_exotic_leaves_with_pear",
        wherein                 = "unilib:tree_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 4,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 1,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = unilib.y_max,
        y_min                   = 0,
    })

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_exotic_leaves_with_plum",
        wherein                 = "unilib:tree_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 4,
        noise_params            = {
            octaves     = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 1,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = unilib.y_max,
        y_min                   = 0,
    })

end
