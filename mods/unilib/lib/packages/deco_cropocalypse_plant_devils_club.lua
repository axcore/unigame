---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_devils_club = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_devils_club.init()

    return {
        description = "Devil's club as decoration",
        depends = {"biome_grave_graveyard", "plant_devils_club"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_devils_club.post()

    unilib.register_decoration_complete("cropocalypse_plant_devils_club", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_devils_club"
        biomes = "grave_graveyard",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
