---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_grass_kauri = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_grass_kauri.init()

    return {
        description = "Kauri grass",
        depends = {"biome_aotearoa_lowland", "dirt_antipodean", "grass_kauri"},
    }

end

function unilib.pkg.deco_aotearoa_grass_kauri.post()

    unilib.register_decoration_complete("aotearoa_grass_kauri", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "grass_kauri"
        biomes = "aotearoa_lowland_kauri_forest",
        place_on = "unilib:dirt_ordinary_with_litter_dry",
        y_max = 80,
        y_min = 12,
    })

end
