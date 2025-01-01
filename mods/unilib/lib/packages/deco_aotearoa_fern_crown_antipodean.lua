---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_fern_crown_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_fern_crown_antipodean.init()

    return {
        description = "Antipoedan crown fern as decoration",
        depends = "fern_crown_antipodean",
        at_least_one = {
            {
                "biome_aotearoa_coastal",
                "biome_aotearoa_highland",
                "biome_aotearoa_lowland",
                "biome_aotearoa_scrubland",
            },
            {"dirt_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_fern_crown_antipodean.post()

    unilib.register_decoration_complete("aotearoa_fern_crown_antipodean_normal", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "fern_crown_antipodean_normal"
        biomes = {
            "aotearoa_coastal_muttonbird_scrub",
            "aotearoa_highland_mountain_beech_forest",
            "aotearoa_lowland_kamahi_forest",
            "aotearoa_scrubland_manuka",
        },
        place_on = {
            "unilib:dirt_antipodean_with_moss",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        y_max = 120,
        y_min = 3,
    })
    unilib.register_decoration_complete("aotearoa_fern_crown_antipodean_dense", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "fern_crown_antipodean_dense"
        biomes = {
            "aotearoa_lowland_beech_forest",
            "aotearoa_lowland_fiordland_forest",
        },
        place_on = "unilib:dirt_antipodean_dark_with_litter_beech",
        y_max = 80,
        y_min = 12,
    })

end
