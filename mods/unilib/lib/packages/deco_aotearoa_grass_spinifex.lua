---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_grass_spinifex = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_grass_spinifex.init()

    return {
        description = "Spinifex grass as decoration",
        depends = "grass_spinifex",
        at_least_one = {
            {"biome_aotearoa_dunes", "biome_aotearoa_shore"},
            {"sand_ironsand", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_grass_spinifex.post()

    unilib.register_decoration_now("aotearoa_grass_spinifex", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "grass_spinifex"
        biomes = {
            "aotearoa_dunes_ironsand",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_sand",
            "aotearoa_shore_ironsand_beach",
            "aotearoa_shore_sandy_beach",
        },
        place_on = {"unilib:sand_ironsand", "unilib:sand_ordinary"},
        y_max = 5,
        y_min = 2,
    })

end
