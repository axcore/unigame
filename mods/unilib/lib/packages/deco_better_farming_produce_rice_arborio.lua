---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_rice_arborio = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_rice_arborio.init()

    return {
        description = "Arborio rice as decoration",
        depends = {"dirt_ordinary", "produce_rice_arborio"},
        at_least_one = {"biome_default_grassland", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_better_farming_produce_rice_arborio.post()

    unilib.register_decoration_now("better_farming_produce_rice_arborio", nil, {
        -- From better_farming, rice.lua
        -- Completes decoration in package "produce_rice_arborio"
        biomes = {"default_grassland", "default_rainforest"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
