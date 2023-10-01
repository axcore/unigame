---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_dry.init()

    return {
        description = "Dry grass as decoration",
        depends = {"biome_farlands_savanna", "dirt_ordinary", "grass_dry"},
    }

end

function unilib.pkg.deco_farlands_grass_dry.post()

    for i = 1, 5 do

        unilib.register_decoration_now("default_grass_dry_" .. i, "farlands_grass_dry_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_dry"
            biomes = "farlands_savanna",
            place_on = "unilib:dirt_ordinary_with_turf_dry",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end

