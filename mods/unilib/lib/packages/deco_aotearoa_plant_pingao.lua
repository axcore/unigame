---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_pingao = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_pingao.init()

    return {
        description = "Pingao as decoration",
        depends = "plant_pingao",
        at_least_one = {
            {"biome_aotearoa_dunes", "biome_aotearoa_shore"},
            {"sand_ironsand", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_plant_pingao.post()

    unilib.register_decoration_now("aotearoa_plant_pingao", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_pingao"
        biomes = {
            "aotearoa_dunes_ironsand",
            "aotearoa_shore_ironsand_beach",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_sand",
            "aotearoa_shore_sandy_beach",
        },
        place_on = {"unilib:sand_ironsand", "unilib:sand_ordinary"},
        y_max = 5,
        y_min = 2,
    })

end
