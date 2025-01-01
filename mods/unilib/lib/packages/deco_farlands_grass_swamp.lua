---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_swamp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_swamp.init()

    return {
        description = "Swamp grass as decoration",
        depends = {"biome_farlands_swamp", "grass_swamp"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_swamp"},
    }

end

function unilib.pkg.deco_farlands_grass_swamp.post()

    for i = 1, 5 do

        unilib.register_decoration_complete("farlands_grass_swamp_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_swamp"
            biomes = "farlands_swamp",
            place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_swamp"},
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

    end

end
