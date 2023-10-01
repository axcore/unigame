---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    rocks/mineral
-- Code:    GPLv2
-- Media:   GPLv2
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_rocks_stone_pegmatite_white_with_cassiterite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.rocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_rocks_stone_pegmatite_white_with_cassiterite.init()

    return {
        description = "White pegmatite with cassiterite as ore",
        depends = {"stone_pegmatite_white", "stone_pegmatite_white_with_cassiterite"},
    }

end

function unilib.pkg.ore_rocks_stone_pegmatite_white_with_cassiterite.post()

    unilib.register_ore({
        -- From rocks/mineral/pegmatite.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_pegmatite_white_with_cassiterite",
        wherein                 = "unilib:stone_pegmatite_white",

        clust_num_ores          = 9,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 3,

        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 1,
            scale = 1,
            seed = 17345,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = -0.1,
    })

end
