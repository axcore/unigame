---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_grass_graveyard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_grass_graveyard.init()

    return {
        description = "Graveyard grass as decoration",
        depends = {"biome_grave_graveyard", "grass_graveyard"},
    }

end

function unilib.pkg.deco_cropocalypse_grass_graveyard.post()

    unilib.register_decoration_now("cropocalypse_grass_graveyard", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "grass_graveyard"
        biomes = "grave_graveyard",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
