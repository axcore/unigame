---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_jungle_exotic_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_jungle_exotic_log.init()

    return {
        description = "Exotic jungle tree log as decoration",
        depends = {"biome_farlands_rainforest", "mushroom_brown", "tree_jungle_exotic"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_forest"},
    }

end

function unilib.pkg.deco_farlands_tree_jungle_exotic_log.post()

    unilib.register_decoration_complete("farlands_tree_jungle_exotic_log", nil, {
        -- From farlands, mapgen/mapgen.lua (schematic in code)
        -- Completes decoration in package "tree_jungle_exotic"
        biomes = {"farlands_rainforest", "farlands_rainforest_swamp"},
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_forest"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
