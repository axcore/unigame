---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_fireflies_misc_firefly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_fireflies_misc_firefly.init()

    return {
        description = "Fireflies as decoration",
        depends = {"dirt_ordinary", "misc_firefly"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
        },
    }

end

function unilib.pkg.deco_fireflies_misc_firefly.post()

    unilib.register_decoration_now("fireflies_misc_firefly", nil, {
        -- From fireflies/init.lua
        -- Completes decoration in package "misc_firefly"
        biomes = {
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_rainforest",
            "default_rainforest_swamp"
        },
        place_on = {
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = -1,
    })

    unilib.register_decoration_now("fireflies_misc_firefly_hidden", nil, {
        -- From fireflies/init.lua
        -- Completes decoration in package "misc_firefly"
        biomes = {
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_rainforest",
            "default_rainforest_swamp"
        },
        place_on = {
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = -1,
    })

end
