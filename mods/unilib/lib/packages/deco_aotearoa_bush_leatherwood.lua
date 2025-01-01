---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_bush_leatherwood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_bush_leatherwood.init()

    return {
        description = "Leatherwood bush as decoration",
        depends = "bush_leatherwood",
        at_least_one = {
            {
                "biome_aotearoa_alpine",
                "biome_aotearoa_coastal",
                "biome_aotearoa_highland",
            },
            {
                "dirt_antipodean",
                "dirt_custom_antipodean",
                "dirt_ordinary",
                "stone_schist_antipodean",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_bush_leatherwood.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_bush_leatherwood_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "bush_leatherwood"
            biomes = "aotearoa_coastal_muttonbird_scrub",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 3,
        })
        unilib.register_decoration_complete("aotearoa_bush_leatherwood_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "bush_leatherwood"
            biomes = {
                "aotearoa_alpine_fellfield",
                "aotearoa_highland_mountain_tussock",
                "aotearoa_highland_pahautea_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_with_moss",
                "unilib:dirt_ordinary_with_turf_highland_mountain_tussock",
                "unilib:stone_schist_antipodean",
            },
            y_max = 122,
            y_min = 83,
        })

    end

end
