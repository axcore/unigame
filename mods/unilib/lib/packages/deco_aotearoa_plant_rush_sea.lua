---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_rush_sea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_rush_sea.init()

    return {
        description = "Sea rush as decoration",
        depends = {"biome_aotearoa_dunes", "dirt_mud_antipodean", "plant_rush_sea"},
    }

end

function unilib.pkg.deco_aotearoa_plant_rush_sea.post()

    unilib.register_decoration_now("aotearoa_plant_rush_sea", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_rush_sea"
        biomes = "aotearoa_dunes_salt_marsh",
        place_on = "unilib:dirt_mud_antipodean_dry",
        y_max = 5,
        y_min = 1,
    })

end
