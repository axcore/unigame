---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_bean_adzuki = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_bean_adzuki.init()

    return {
        description = "Adzuki beans as decoration",
        depends = {"produce_bean_adzuki", "dirt_ordinary"},
        at_least_one = {"biome_default_grassland", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_better_farming_produce_bean_adzuki.post()

    unilib.register_decoration_complete("better_farming_produce_bean_adzuki", nil, {
        -- From better_farming, adzuki.lua
        -- Completes decoration in package "produce_bean_adzuki"
        biomes = "default_grassland", "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
