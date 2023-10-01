---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_cucumber_english = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_cucumber_english.init()

    return {
        description = "English cucumber as decoration",
        depends = "produce_cucumber_english",
        at_least_one = {
            {"biome_default_desert", "biome_default_forest_coniferous"},
            {"dirt_ordinary", "sand_desert"},
        },
    }

end

function unilib.pkg.deco_better_farming_produce_cucumber_english.post()

    unilib.register_decoration_now("better_farming_produce_cucumber_english", nil, {
        -- From better_farming, cucumber.lua
        -- Completes decoration in package "produce_cucumber_english"
        biomes = {"default_desert", "default_forest_coniferous"},
        place_on = {"unilib:dirt_ordinary_with_litter_coniferous", "unilib:sand_desert"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
