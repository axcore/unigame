---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_vallee_des_roses_flower_marigold_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_vallee_des_roses_flower_marigold_small.init()

    return {
        description = "Small marigold as decoration",
        depends = {"dirt_ordinary", "flower_marigold_small"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
        },
    }

end

function unilib.pkg.deco_vallee_des_roses_flower_marigold_small.post()

    unilib.register_decoration_now("vallee_des_roses_flower_marigold_small", nil, {
        -- From vallee_des_roses/init.lua
        -- Completes decoration in package "flower_marigold_small"
        biomes = {"default_forest_coniferous", "default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 200,
        y_min = 1,
    })

end
