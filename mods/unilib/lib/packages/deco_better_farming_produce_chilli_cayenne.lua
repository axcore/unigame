---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_chilli_cayenne = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_chilli_cayenne.init()

    return {
        description = "Cayenne chilli as decoration",
        depends = {"biome_default_desert", "produce_chilli_cayenne", "sand_desert"},
    }

end

function unilib.pkg.deco_better_farming_produce_chilli_cayenne.post()

    unilib.register_decoration_complete("better_farming_produce_chilli_cayenne", nil, {
        -- From better_farming, chilie.lua
        -- Completes decoration in package "produce_chilli_cayenne"
        biomes = "default_desert",
        place_on = "unilib:sand_desert",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
