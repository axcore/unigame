---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_bush_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_bush_exotic.init()

    return {
        description = "Exotic bush leaves with fruit, implemented as an ore",
        depends = {"bush_exotic", "fruit_berry_exotic"},
    }

end

function unilib.pkg.ore_farlands_bush_exotic.post()

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:bush_exotic_leaves_with_berry",
        wherein                 = "unilib:bush_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 10 * 10 * 10,
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
