---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_bamboo_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_bamboo_exotic.init()

    return {
        description = "Exotic bamboo tree as decoration",
        depends = {"biome_farlands_forest_bamboo", "dirt_ordinary", "tree_bamboo_exotic"},
    }

end

function unilib.pkg.deco_farlands_tree_bamboo_exotic.post()

    for i = 1, 2 do

        unilib.register_decoration_now("farlands_tree_bamboo_exotic_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_bamboo_exotic"
            biomes = "farlands_forest_bamboo",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
