---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_anagallis_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_anagallis_yellow.init()

    return {
        description = "Yellow anagallis as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "flower_anagallis_yellow"},
    }

end

function unilib.pkg.deco_herbs_flower_anagallis_yellow.post()

    unilib.register_decoration_complete("herbs_flower_anagallis_yellow", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_anagallis_yellow"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
