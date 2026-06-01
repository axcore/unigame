---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_lily_calla_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_lily_calla_large.init()

    return {
        description = "Large calla lily as decoration",
        depends = {"dirt_ordinary_with_turf", "liquid_water_ordinary"},
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_swamp",
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_lily_calla_large.post()

    unilib.register_decoration_complete("elysflowers_flower_lily_calla_large", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_lily_calla_large"
        biomes = {"default_forest_deciduous", "ethereal_forest_deciduous", "ethereal_swamp"},
        num_spawn_by = 1,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
