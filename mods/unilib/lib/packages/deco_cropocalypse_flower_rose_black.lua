---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_rose_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_rose_black.init()

    return {
        description = "Black rose as decoration",
        depends = {"biome_grave_graveyard", "flower_rose_black"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_rose_black.post()

    unilib.register_decoration_complete("cropocalypse_flower_rose_black", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_rose_black"
        biomes = "grave_graveyard",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
