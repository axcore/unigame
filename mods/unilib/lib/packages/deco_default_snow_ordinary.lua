---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_snow_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_snow_ordinary.init()

    return {
        description = "Ordinary snow as decoration",
        depends = "snow_ordinary",
        at_least_one = {"dirt_permafrost_ordinary", "gravel_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.deco_default_snow_ordinary.post()

    unilib.register_decoration_complete("default_snow_ordinary", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "snow_ordinary"
        biomes = {"default_tundra", "default_tundra_beach"},
        place_on = {
            "unilib:dirt_permafrost_ordinary_with_moss",
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
        },
        y_max = 50,
        y_min = 1,
    })

end
