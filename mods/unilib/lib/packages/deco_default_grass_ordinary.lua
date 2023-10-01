---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_grass_ordinary.init()

    return {
        description = "Ordinary grass as decoration",
        depends = {"dirt_ordinary", "grass_ordinary"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_default_grass_ordinary.post()

    for i = 1, 5 do

        unilib.register_decoration_now("default_grass_ordinary_" .. i, nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "grass_ordinary"
            biomes = {"default_forest_deciduous", "default_grassland"},
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
