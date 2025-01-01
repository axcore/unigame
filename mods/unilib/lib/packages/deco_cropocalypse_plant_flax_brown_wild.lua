---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_flax_brown_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_flax_brown_wild.init()

    return {
        description = "Wild brown flax plant as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "plant_flax_brown_wild"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_flax_brown_wild.post()

    unilib.register_decoration_complete("cropocalypse_plant_flax_brown_wild", nil, {
        -- From cropocalypse/plants.lua
        -- Completes decoration in package "plant_flax_brown_wild"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
