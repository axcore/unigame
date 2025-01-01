---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_jungle.init()

    return {
        description = "Jungle grass as decoration",
        depends = {"biome_farlands_rainforest", "dirt_ordinary_with_turf_forest", "grass_jungle"},
    }

end

function unilib.pkg.deco_farlands_grass_jungle.post()

    unilib.register_decoration_complete("default_grass_jungle", "farlands_grass_jungle", {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "grass_jungle"
        biomes = "farlands_rainforest",
        place_on = "unilib:dirt_ordinary_with_turf_forest",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
