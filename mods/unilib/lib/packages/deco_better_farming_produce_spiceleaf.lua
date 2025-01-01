---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_spiceleaf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_spiceleaf.init()

    return {
        description = "Spiceleaf as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "produce_spiceleaf"},
    }

end

function unilib.pkg.deco_better_farming_produce_spiceleaf.post()

    unilib.register_decoration_complete("better_farming_produce_spiceleaf", nil, {
        -- From better_farming, spiceleaf.lua
        -- Completes decoration in package "produce_spiceleaf"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
