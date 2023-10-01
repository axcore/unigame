---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_papaver_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_papaver_red.init()

    return {
        description = "Red papaver as decoration",
        depends = {"dirt_ordinary", "flower_papaver_red"},
        at_least_one = {"biome_default_grassland", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_herbs_flower_papaver_red.post()

    unilib.register_decoration_now("herbs_flower_papaver_red", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_papaver_red"
        biomes = {"default_grassland", "default_rainforest"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest", "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
