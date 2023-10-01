---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_flowers_flower_waterlily_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_flowers_flower_waterlily_ordinary.init()

    return {
        description = "Ordinary waterlily as decoration",
        depends = {"dirt_ordinary", "flower_waterlily_ordinary"},
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
            "biome_default_savanna",
        },
    }

end

function unilib.pkg.deco_flowers_flower_waterlily_ordinary.post()

    unilib.register_decoration_now("flowers_flower_waterlily_ordinary", nil, {
        -- From flowers/mapgen.lua
        -- Completes decoration in package "flower_waterlily_ordinary"
        biomes = {
            "default_forest_deciduous_shore",
            "default_rainforest_swamp",
            "default_savanna_shore",
        },
        place_on = "unilib:dirt_ordinary",
        y_max = 0,
        y_min = 0,
    })

end
