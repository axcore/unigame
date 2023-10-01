---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_ipe_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_ipe_yellow.init()

    return {
        description = "Yellow ipe tree as decoration",
        depends = {"biome_farlands_forest_deciduous", "dirt_ordinary", "tree_ipe_yellow"},
    }

end

function unilib.pkg.deco_farlands_tree_ipe_yellow.post()

    unilib.register_decoration_now("farlands_tree_ipe_yellow", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "farlands_tree_ipe_yellow"
        biomes = "farlands_forest_deciduous_tall",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
