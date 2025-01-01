---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_millet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_millet.init()

    return {
        description = "Millet as decoration",
        depends = "produce_millet",
        at_least_one = {
            {"biome_default_forest_deciduous", "biome_default_grassland"},
            {"dirt_ordinary", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_better_farming_produce_millet.post()

    unilib.register_decoration_complete("better_farming_produce_millet", nil, {
        -- From better_farming, millet.lua
        -- Completes decoration in package "produce_millet"
        biomes = {"default_forest_deciduous_ocean", "default_grassland", "default_grassland_beach"},
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_ordinary"},
        y_max = 15,
        y_min = 0,
    })

end
