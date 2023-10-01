---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_baobab = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_baobab.init()

    return {
        description = "Baobab tree as decoration",
        depends = {"biome_farlands_savanna", "dirt_ordinary", "tree_baobab"},
    }

end

function unilib.pkg.deco_farlands_tree_baobab.post()

    for i = 1, 3 do

        unilib.register_decoration_now("farlands_tree_baobab_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_baobab"
            place_on = "unilib:dirt_ordinary_with_turf_dry",
            biomes = "farlands_savanna",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
