---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_oat_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_oat_wild.init()

    return {
        description = "Wild oat plant as decoration",
        depends = {"dirt_ordinary", "plant_oat_wild"},
        at_least_one = {
            "biome_farlands_forest_deciduous",
            "biome_farlands_grassland",
            "biome_farlands_savanna",
        },
    }

end

function unilib.pkg.deco_farlands_plant_oat_wild.post()

    if unilib.pkg_executed_table["biome_farlands_forest_deciduous"] ~= nil or
            unilib.pkg_executed_table["biome_farlands_grassland"] ~= nil then

        unilib.register_decoration_now("farlands_plant_oat_wild", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "plant_oat_wild"
            biomes = {
                "farlands_forest_deciduous",
                "farlands_forest_deciduous_tall",
                "farlands_grassland",
            },
            place_on = "unilib:dirt_ordinary_with_turf",
        })

    end

    if unilib.pkg_executed_table["biome_farlands_savanna"] ~= nil then

        unilib.register_decoration_now("farlands_plant_oat_wild_dry", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "plant_oat_wild"
            biomes = "farlands_savanna",
            place_on = "unilib:dirt_ordinary_with_turf_dry",
        })

    end

end
