---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_grass_jungle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_grass_jungle.init()

    return {
        description = "Jungle grass as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "grass_jungle"},
    }

end

function unilib.pkg.deco_default_grass_jungle.post()

    unilib.register_decoration_now("default_grass_jungle", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "grass_jungle"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
