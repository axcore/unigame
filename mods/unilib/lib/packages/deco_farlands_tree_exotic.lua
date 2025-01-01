---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_exotic.init()

    return {
        description = "Exotic tree as decoration",
        depends = {"biome_farlands_forest_deciduous", "dirt_ordinary", "tree_exotic"},
    }

end

function unilib.pkg.deco_farlands_tree_exotic.post()

    for i = 1, 3 do

        unilib.register_decoration_complete("farlands_tree_exotic_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_exotic"
            biomes = "farlands_forest_deciduous_tall",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

    end

    for i = 4, 5 do

        unilib.register_decoration_complete("farlands_tree_exotic_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_exotic"
            biomes = "farlands_forest_deciduous",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

    end

end
