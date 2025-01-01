---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_vallee_des_roses_flower_poppy_brittle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_vallee_des_roses_flower_poppy_brittle.init()

    return {
        description = "Brittle poppy as decoration",
        depends = {"dirt_ordinary", "flower_poppy_brittle"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
        },
    }

end

function unilib.pkg.deco_vallee_des_roses_flower_poppy_brittle.post()

    unilib.register_decoration_complete("vallee_des_roses_flower_poppy_brittle", nil, {
        -- Original to unilib, based on the decoration in the "flower_poppy_brittle" package
        -- Completes decoration in package "flower_poppy_brittle"
        biomes = {"default_forest_coniferous", "default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 200,
        y_min = 1,
    })

end
