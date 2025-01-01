---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_tussock_bristle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_tussock_bristle.init()

    return {
        description = "Bristle tussock as decoration",
        depends = "plant_tussock_bristle",
        at_least_one = {
            {"biome_aotearoa_alpine", "biome_aotearoa_highland"},
            {"dirt_custom_antipodean", "stone_schist_antipodean", "sand_volcanic"},
        },
    }

end

function unilib.pkg.deco_aotearoa_plant_tussock_bristle.post()

    unilib.register_decoration_complete("aotearoa_plant_tussock_bristle", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_tussock_bristle"
        biomes = {
            "aotearoa_alpine_fellfield",
            "aotearoa_highland_mountain_tussock",
            "aotearoa_highland_rangipo_desert",
        },
        place_on = {
            "unilib:dirt_ordinary_with_turf_highland_mountain_tussock",
            "unilib:sand_volcanic",
            "unilib:stone_schist_antipodean",
        },
        y_max = 138,
        y_min = 78,
    })

end
