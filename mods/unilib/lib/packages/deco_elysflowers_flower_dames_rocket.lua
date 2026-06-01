---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_dames_rocket = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_dames_rocket.init()

    return {
        description = "Dame's rocket as decoration",
        at_least_one = {
            {
                "biome_default_forest_deciduous",
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grove",
            },
            {
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_grove",
            },
            {
                "tree_apple",
                "tree_aspen",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_dames_rocket.post()

    unilib.register_decoration_complete("elysflowers_flower_dames_rocket", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_dames_rocket"
        biomes = {"default_forest_deciduous", "ethereal_forest_deciduous", "ethereal_grove"},
        num_spawn_by = -1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_grove"},
        spawn_by = {"unilib:tree_apple_trunk", "unilib:tree_aspen_trunk"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
