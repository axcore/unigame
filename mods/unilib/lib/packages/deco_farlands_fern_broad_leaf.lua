---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_fern_broad_leaf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_fern_broad_leaf.init()

    return {
        description = "Broad leaf fern as decoration",
        depends = {
            "biome_farlands_rainforest",
            "dirt_ordinary_with_turf_forest",
            "fern_broad_leaf",
        },
    }

end

function unilib.pkg.deco_farlands_fern_broad_leaf.post()

    unilib.register_decoration_complete("farlands_fern_broad_leaf", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "fern_broad_leaf"
        biomes = "farlands_rainforest",
        place_on = "unilib:dirt_ordinary_with_turf_forest",
    })

end
