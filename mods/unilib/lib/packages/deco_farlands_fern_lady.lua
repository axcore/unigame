---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_fern_lady = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_fern_lady.init()

    return {
        description = "Lady fern as decoration",
        depends = "fern_lady",
        optional = {
            "biome_farlands_forest_coniferous",
            "biome_farlands_rainforest",
            "dirt_ordinary_with_litter_leafy",
            "dirt_ordinary_with_turf_forest",
        },
    }

end

function unilib.pkg.deco_farlands_fern_lady.post()

    if unilib.pkg_executed_table["biome_farlands_forest_coniferous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_litter_leafy"] ~= nil then

        unilib.register_decoration_now("farlands_fern_lady_1", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "fern_lady"
            biomes = "farlands_forest_coniferous_tall",
            place_on = "unilib:dirt_ordinary_with_litter_leafy",
        })

    end

    if unilib.pkg_executed_table["biome_farlands_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_forest"] ~= nil then

        unilib.register_decoration_now("farlands_fern_lady_2", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "fern_lady"
            biomes = "farlands_rainforest",
            place_on = "unilib:dirt_ordinary_with_turf_forest",
        })

    end

end
