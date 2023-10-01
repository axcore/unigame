---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_bracken = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_bracken.init()

    return {
        description = "Bracken as decoration",
        depends = {"dirt_ordinary", "plant_bracken"},
        at_least_one = {"biome_aotearoa_coastal", "biome_aotearoa_scrubland"},
    }

end

function unilib.pkg.deco_aotearoa_plant_bracken.post()

    if unilib.pkg_executed_table["biome_aotearoa_coastal"] ~= nil then

        unilib.register_decoration_now("aotearoa_plant_bracken_sparse", nil, {
            -- From aotearoa/spawn_plants.lua
            -- Completes decoration in package "plant_bracken"
            biomes = "aotearoa_coastal_pohutukawa_forest",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 5,
        })
        unilib.register_decoration_now("aotearoa_plant_bracken_clumped", nil, {
            -- From aotearoa/spawn_plants.lua
            -- Completes decoration in package "plant_bracken"
            biomes = "aotearoa_coastal_scrub",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 80,
            y_min = 5,
        })

    end
    if unilib.pkg_executed_table["biome_aotearoa_scrubland"] ~= nil then

        unilib.register_decoration_now("aotearoa_plant_bracken_dense", nil, {
            -- From aotearoa/spawn_plants.lua
            -- Completes decoration in package "plant_bracken"
            biomes = {
                "aotearoa_scrubland_broadleaf",
                "aotearoa_scrubland_geothermal",
                "aotearoa_scrubland_manuka",
            },
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 80,
            y_min = 12,
        })

    end

end
