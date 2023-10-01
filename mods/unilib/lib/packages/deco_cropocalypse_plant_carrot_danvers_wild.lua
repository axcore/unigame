---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_carrot_danvers_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_carrot_danvers_wild.init()

    return {
        description = "Wild danvers carrot plant as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "plant_carrot_danvers_wild"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_carrot_danvers_wild.post()

    unilib.register_decoration_now("cropocalypse_plant_carrot_danvers_wild", nil, {
        -- From cropocalypse/plants.lua
        -- Completes decoration in package "plant_carrot_danvers_wild"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
