---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_agave = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_agave.init()

    return {
        description = "Agave as decoration",
        depends = {"biome_default_desert", "produce_agave", "sand_desert"},
    }

end

function unilib.pkg.deco_better_farming_produce_agave.post()

    unilib.register_decoration_now("better_farming_produce_agave", nil, {
        -- From better_farming, agave.lua
        -- Completes decoration in package "produce_agave"
        biomes = "default_desert",
        place_on = "unilib:sand_desert",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
