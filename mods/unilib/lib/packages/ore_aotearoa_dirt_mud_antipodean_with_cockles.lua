---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_dirt_mud_antipodean_with_cockles = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_dirt_mud_antipodean_with_cockles.init()

    return {
        description = "Antipodean mud with cockles as ore",
        depends = {
            "biome_aotearoa_shore",
            "dirt_mud_antipodean",
            "dirt_mud_antipodean_with_cockles",
        },
    }

end

function unilib.pkg.ore_aotearoa_dirt_mud_antipodean_with_cockles.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "puff",
        ore                     = "unilib:dirt_mud_antipodean_with_cockles",
        wherein                 = "unilib:dirt_mud_antipodean_dry",

        biomes                  = {
          "aotearoa_shore_northern_estuary",
          "aotearoa_shore_southern_estuary",
        },
        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 3,
        noise_params            = {
            octaves = 2,
            offset = 0,
            persist = 0.4,
            scale = 0.8,
            seed = 4607,
            spread = {x = 32, y = 32, z = 32},
        },
        noise_threshold         = 0.19,
        y_max                   = 0,
        y_min                   = -7,
    })

end
