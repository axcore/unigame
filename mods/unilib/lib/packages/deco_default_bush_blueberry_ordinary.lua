---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_bush_blueberry_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_bush_blueberry_ordinary.init()

    return {
        description = "Blueberry bush as decoration",
        depends = {"bush_blueberry_ordinary", "dirt_ordinary"},
        at_least_one = {"biome_default_grassland", "biome_default_grassland_snowy"},
    }

end

function unilib.pkg.deco_default_bush_blueberry_ordinary.post()

    unilib.register_decoration_complete("default_bush_blueberry_ordinary", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "bush_blueberry_ordinary"
        biomes = {"default_grassland", "default_grassland_snowy"},
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
