---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_wiwi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_wiwi.init()

    return {
        description = "Wiwi as decoration",
        depends = "plant_wiwi",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_dunes"},
            {"dirt_ordinary", "gravel_ordinary", "sand_ironsand", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_plant_wiwi.post()

    unilib.register_decoration_now("aotearoa_plant_wiwi", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_wiwi"
        biomes = {
            "aotearoa_coastal_muttonbird_scrub",
            "aotearoa_coastal_scrub",
            "aotearoa_dunes_gravel",
            "aotearoa_dunes_ironsand",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_sand",
        },
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:gravel_ordinary",
            "unilib:sand_ironsand",
            "unilib:sand_ordinary",
        },
        y_max = 80,
        y_min = 3,
    })

end
