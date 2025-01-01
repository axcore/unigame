---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_deciduous = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_deciduous.init()

    return {
        description = "Deciduous forest grass as decoration",
        depends = {"biome_farlands_forest_deciduous", "dirt_ordinary", "grass_deciduous"},
    }

end

function unilib.pkg.deco_farlands_grass_deciduous.post()

    unilib.register_decoration_complete("farlands_grass_deciduous", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "grass_deciduous"
        biomes = "farlands_forest_deciduous_tall",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
