---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_tussock_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_tussock_red.init()

    return {
        description = "Red tussock as decoration",
        depends = {"dirt_ordinary", "plant_tussock_red"},
        at_least_one = {
            "biome_aotearoa_coastal",
            "biome_aotearoa_highland",
            "biome_aotearoa_scrubland",
        },
    }

end

function unilib.pkg.deco_aotearoa_plant_tussock_red.post()

    unilib.register_decoration_now("aotearoa_plant_tussock_red", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_tussock_red"
        biomes = {
            "aotearoa_coastal_tussock",
            "aotearoa_highland_mountain_tussock",
            "aotearoa_scrubland_matagouri",
        },
        place_on = "unilib:dirt_ordinary_with_turf_dry",
        y_max = 145,
        y_min = 3,
    })

end
