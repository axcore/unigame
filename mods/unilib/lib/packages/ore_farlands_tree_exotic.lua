---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_tree_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

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

function unilib.pkg.ore_farlands_tree_exotic.post()

    if unilib.global.pkg_executed_table["fruit_apple_exotic"] ~= nil then

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
            y_max                   = unilib.constant.y_max,
            y_min                   = 0,
        })

    end

    if unilib.global.pkg_executed_table["fruit_peach_exotic"] ~= nil then

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
            y_max                   = unilib.constant.y_max,
            y_min                   = 0,
        })

    end

    if unilib.global.pkg_executed_table["fruit_pear_exotic"] ~= nil then

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
            y_max                   = unilib.constant.y_max,
            y_min                   = 0,
        })

    end

    if unilib.global.pkg_executed_table["fruit_plum_exotic"] ~= nil then

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
            y_max                   = unilib.constant.y_max,
            y_min                   = 0,
        })

    end

end
