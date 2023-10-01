---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_herb_medicinal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_herb_medicinal.init()

    return {
        description = "Medicinal herb as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "produce_herb_medicinal"},
    }

end

function unilib.pkg.deco_better_farming_produce_herb_medicinal.post()

    unilib.register_decoration_now("better_farming_produce_herb_medicinal", nil, {
        -- From better_farming, medecinal_plant.lua
        -- Completes decoration in package "produce_herb_medicinal"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_coniferous",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
