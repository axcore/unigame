---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_young_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_young_jungle.init()

    return {
        description = "Young jungle tree as decoration",
        depends = {
            "biome_farlands_rainforest",
            "dirt_ordinary_with_turf_forest",
            "tree_young_jungle",
        },
    }

end

function unilib.pkg.deco_farlands_tree_young_jungle.post()

    unilib.register_decoration_complete("farlands_tree_young_jungle", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "tree_young_jungle"
        biomes = "farlands_rainforest",
        place_on = "unilib:dirt_ordinary_with_turf_forest",
    })

end
