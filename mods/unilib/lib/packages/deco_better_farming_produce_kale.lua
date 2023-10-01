---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_kale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_kale.init()

    return {
        description = "Kale as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "produce_kale"},
    }

end

function unilib.pkg.deco_better_farming_produce_kale.post()

    unilib.register_decoration_now("better_farming_produce_kale", nil, {
        -- From better_farming, kale.lua
        -- Completes decoration in package "produce_kale"
        biomes = "default_forest_coniferous",
        place_on = "unilib:dirt_ordinary_with_litter_coniferous",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
