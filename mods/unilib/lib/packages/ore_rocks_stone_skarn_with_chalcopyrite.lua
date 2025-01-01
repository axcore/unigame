---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_rocks_stone_skarn_with_chalcopyrite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_rocks_stone_skarn_with_chalcopyrite.init()

    return {
        description = "Skarn with chalcopyrite as ore",
        depends = {"stone_skarn", "stone_skarn_with_chalcopyrite"},
    }

end

function unilib.pkg.ore_rocks_stone_skarn_with_chalcopyrite.post()

    unilib.register_ore({
        -- From rocks/mineral/skarn.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_skarn_with_chalcopyrite",
        wherein                 = "unilib:stone_skarn",

        clust_num_ores          = 12,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,

        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 1,
            scale = 1,
            seed = 2571,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.333,
    })

end
