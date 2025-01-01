---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_carrot_chantenay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_carrot_chantenay.init()

    return {
        description = "Chantenay carrot as decoration",
        depends = {"dirt_ordinary", "produce_carrot_chantenay"},
        at_least_one = {"biome_default_desert", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_better_farming_produce_carrot_chantenay.post()

    unilib.register_decoration_complete("better_farming_produce_carrot_chantenay", nil, {
        -- From better_farming, carrot.lua
        -- Completes decoration in package "produce_carrot_chantenay"
        biomes = {"default_desert", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_litter_coniferous",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
