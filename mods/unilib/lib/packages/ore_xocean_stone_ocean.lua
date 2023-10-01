---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_xocean_stone_ocean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_xocean_stone_ocean.init()

    return {
        description = "Ocean stone as ore",
        depends = {"sand_ordinary", "stone_ocean"},
    }

end

function unilib.pkg.ore_xocean_stone_ocean.post()

    unilib.register_ore({
        -- From xocean/init.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_ocean",
        wherein                 = "unilib:sand_ordinary",

        clust_scarcity          = 32 * 32 * 32,
        clust_size              = 8,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = -316,
            spread = {x = 8, y = 5, z = 8},
        },
        noise_threshold         = 0.0,
        y_max                   = 0,
        y_min                   = -15,
    })

end
