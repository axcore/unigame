---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_trifolium_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_trifolium_red.init()

    return {
        description = "Red trifolium as decoration",
        depends = "flower_trifolium_red",
        at_least_one = {
            {
                "biome_default_forest_coniferous",
                "biome_default_forest_deciduous",
                "biome_default_grassland",
                "biome_default_savanna",
            },
            {"dirt_dry", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_herbs_flower_trifolium_red.post()

    unilib.register_decoration_complete("herbs_flower_trifolium_red", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_trifolium_red"
        biomes = {
            "default_grassland",
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_savanna",
        },
        place_on = {
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
