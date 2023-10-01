---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_frozen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_frozen.init()

    return {
        description = "Frozen grass as decoration",
        depends = {"dirt_ordinary", "grass_frozen"},
        at_least_one = {
            "biome_farlands_icesheet",
            "biome_farlands_taiga",
            "biome_farlands_grassland_snowy",
        },
    }

end

function unilib.pkg.deco_farlands_grass_frozen.post()

    for i = 1, 5 do

        unilib.register_decoration_now("farlands_grass_frozen_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_frozen"
            biomes = {"farlands_grassland_snowy", "farlands_icesheet", "farlands_taiga"},
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end

