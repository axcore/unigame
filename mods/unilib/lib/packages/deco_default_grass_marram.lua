---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_grass_marram = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_grass_marram.init()

    return {
        description = "Marram grass as decoration",
        depends = {"grass_marram", "sand_ordinary"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_default_grass_marram.post()

    unilib.register_decoration_now("default_grass_marram", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "grass_marram"
        biomes = {"default_forest_coniferous_beach", "default_grassland_beach"},
        place_on = "unilib:sand_ordinary",
        y_max = 6,
        y_min = 4,
    })

end
