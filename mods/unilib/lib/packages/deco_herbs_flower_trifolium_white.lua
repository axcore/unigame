---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_trifolium_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_trifolium_white.init()

    return {
        description = "White trifolium as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "flower_trifolium_white"},
    }

end

function unilib.pkg.deco_herbs_flower_trifolium_white.post()

    unilib.register_decoration_now("herbs_flower_trifolium_white", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_trifolium_white"
        biomes = "default_grassland",
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous", "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
