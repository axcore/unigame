---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_grass_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_grass_dry.init()

    return {
        description = "Dry grass as decoration",
        depends = {"biome_default_savanna", "dirt_dry", "grass_dry"},
    }

end

function unilib.pkg.deco_default_grass_dry.post()

    for i = 1, 5 do

        unilib.register_decoration_complete("default_grass_dry_" .. i, nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "grass_dry"
            biomes = "default_savanna",
            place_on = "unilib:dirt_dry_with_turf_dry",
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

    end

end
