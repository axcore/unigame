---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_flower_waterlily_exotic_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_flower_waterlily_exotic_yellow.init()

    return {
        description = "Exotic waterlily with yellow flower as decoration",
        depends = {"dirt_ordinary", "flower_waterlily_exotic_yellow"},
        at_least_one = {
            "biome_farlands_forest_deciduous",
            "biome_farlands_rainforest",
            "biome_farlands_savanna",
        },
    }

end

function unilib.pkg.deco_farlands_flower_waterlily_exotic_yellow.post()

    unilib.register_decoration_complete("farlands_flower_waterlily_exotic_yellow", nil, {
        -- From farlands, flowers/mapgen.lua
        -- Completes decoration in package "flower_waterlily_exotic_yellow"
        biomes = {
            "farlands_forest_deciduous_shore",
            "farlands_rainforest_swamp",
            "farlands_savanna_shore",
        },
        place_on = "unilib:dirt_ordinary",
        y_min = 0,
        y_max = 0,
    })

end
