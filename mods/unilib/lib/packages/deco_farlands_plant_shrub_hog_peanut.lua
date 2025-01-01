---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_shrub_hog_peanut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_shrub_hog_peanut.init()

    return {
        description = "Hog peanut shrub as decoration",
        depends = {
            "biome_farlands_forest_coniferous",
            "dirt_ordinary_with_litter_leafy",
            "plant_shrub_hog_peanut",
        },
    }

end

function unilib.pkg.deco_farlands_plant_shrub_hog_peanut.post()

    unilib.register_decoration_complete("farlands_plant_shrub_hog_peanut", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_shrub_hog_peanut"
        biomes = "farlands_forest_coniferous_tall",
        place_on = "unilib:dirt_ordinary_with_litter_leafy",
    })

end
