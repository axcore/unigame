---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_asparagus_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_asparagus_green.init()

    return {
        description = "Green asparagus as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "produce_asparagus_green"},
    }

end

function unilib.pkg.deco_better_farming_produce_asparagus_green.post()

    unilib.register_decoration_complete("better_farming_produce_asparagus_green", nil, {
        -- From better_farming, aspargus.lua
        -- Completes decoration in package "produce_asparagus_green"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
