---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_leucanthemum_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_leucanthemum_white.init()

    return {
        description = "White leucanthemum as decoration",
        depends = "flower_leucanthemum_white",
        at_least_one = {
            {"biome_default_grassland", "biome_default_savanna"},
            {"dirt_dry", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_herbs_flower_leucanthemum_white.post()

    unilib.register_decoration_complete("herbs_flower_leucanthemum_white", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_leucanthemum_white"
        biomes = {"default_grassland", "default_savanna", "default_savanna_shore"},
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
