---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_bush_pine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_bush_pine.init()

    return {
        description = "Pine bush as decoration",
        depends = {"bush_pine", "dirt_ordinary"},
        at_least_one = {"biome_default_grassland_snowy", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_default_bush_pine.post()

    unilib.register_decoration_complete("default_bush_pine", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "bush_pine"
        biomes = {"default_grassland_snowy", "default_taiga"},
        place_on = "unilib:dirt_ordinary_with_cover_snow",
        y_max = unilib.constant.y_max,
        y_min = 4,
    })

end
