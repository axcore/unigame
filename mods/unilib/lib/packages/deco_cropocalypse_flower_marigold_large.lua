---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_marigold_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_marigold_large.init()

    return {
        description = "Large marigold as decoration",
        depends = "flower_marigold_large",
        at_least_one = {"biome_default_desert", "biome_default_savanna"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_marigold_large.post()

    unilib.register_decoration_complete("cropocalypse_flower_marigold_large", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_marigold_large"
        biomes = {"default_desert", "default_savanna"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
