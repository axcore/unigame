---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_mushroom_amanita_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_mushroom_amanita_green.init()

    return {
        description = "Green amanita mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_amanita_green"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
        },
    }

end

function unilib.pkg.deco_herbs_mushroom_amanita_green.post()

    unilib.register_decoration_now("herbs_mushroom_amanita_green", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "mushroom_amanita_green"
        biomes = {"default_forest_coniferous", "default_forest_deciduous", "default_rainforest"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
