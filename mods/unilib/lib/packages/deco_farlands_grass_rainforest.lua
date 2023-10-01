---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_rainforest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_rainforest.init()

    return {
        description = "Rainforest grass as decoration",
        depends = {"biome_farlands_rainforest", "grass_rainforest"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_forest"},
    }

end

function unilib.pkg.deco_farlands_grass_rainforest.post()

    for i = 1, 5 do

        unilib.register_decoration_now("farlands_grass_rainforest_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_rainforest"
            biomes = {
                "farlands_rainforest",
                "farlands_rainforest_ocean",
                "farlands_rainforest_swamp",
            },
            place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_forest"},
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
