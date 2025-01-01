---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_sand_ordinary_with_pipi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_sand_ordinary_with_pipi.init()

    return {
        description = "Ordinary sand with pipi as ore",
        depends = {"biome_aotearoa_shore", "sand_ordinary", "sand_ordinary_with_pipi"},
    }

end

function unilib.pkg.ore_aotearoa_sand_ordinary_with_pipi.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "puff",
        ore                     = "unilib:sand_ordinary_with_pipi",
        wherein                 = "unilib:sand_ordinary",

        biomes                  = {
          "aotearoa_shore_sandy_beach",
          "aotearoa_shore_shelly_beach",
          "aotearoa_shore_gravel_beach",
        },
        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 3,
        noise_params            = {
            octaves = 2,
            offset = 0,
            persist = 0.5,
            scale = 0.7,
            seed = 4661,
            spread = {x = 32, y = 32, z = 32},
        },
        noise_threshold         = 0.19,
        y_max                   = 0,
        y_min                   = -7,
    })

end
