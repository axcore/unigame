---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_jute = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_jute.init()

    return {
        description = "Jute as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "produce_jute"},
    }

end

function unilib.pkg.deco_better_farming_produce_jute.post()

    unilib.register_decoration_complete("better_farming_produce_jute", nil, {
        -- From better_farming, jute.lua
        -- Completes decoration in package "produce_jute"
        biomes = "default_forest_coniferous",
        place_on = "unilib:dirt_ordinary_with_litter_coniferous",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
