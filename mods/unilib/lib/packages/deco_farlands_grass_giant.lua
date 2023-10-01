---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_giant = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_giant.init()

    return {
        description = "Giant grass as decoration",
        depends = {"biome_farlands_swamp", "dirt_ordinary_with_turf_swamp", "grass_giant"},
    }

end

function unilib.pkg.deco_farlands_grass_giant.post()

    unilib.register_decoration_now("farlands_grass_giant", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "grass_giant"
        biomes = "farlands_swamp",
        place_on = "unilib:dirt_ordinary_with_turf_swamp",
    })

end
