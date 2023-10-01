---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_bamboo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_bamboo.init()

    return {
        description = "Bamboo grass as decoration",
        depends = {"biome_farlands_forest_bamboo", "grass_bamboo"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_litter_leafy"},
    }

end

function unilib.pkg.deco_farlands_grass_bamboo.post()

    unilib.register_decoration_now("farlands_grass_bamboo", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "grass_bamboo"
        biomes = "farlands_forest_bamboo",
        place_on = {"unilib:dirt_ordinary_with_litter_leafy", "unilib:dirt_ordinary_with_turf"},
    })

end
