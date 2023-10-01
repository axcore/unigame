---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_nasturtium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_nasturtium.init()

    return {
        description = "Nasturtium as decoration",
        depends = "flower_nasturtium",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_nasturtium.post()

    unilib.register_decoration_now("cropocalypse_flower_nasturtium", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_nasturtium"
        biomes = {"default_forest_deciduous", "default_rainforest"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
