---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_acacia_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_acacia_exotic.init()

    return {
        description = "Exotic acacia tree as decoration",
        depends = {"biome_farlands_savanna", "dirt_ordinary", "tree_acacia_exotic"},
    }

end

function unilib.pkg.deco_farlands_tree_acacia_exotic.post()

    unilib.register_decoration_now("farlands_tree_acacia_exotic", nil, {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/acacia_tree.mts
        -- Completes decoration in package "tree_acacia_exotic"
        biomes = "farlands_savanna",
        place_on = "unilib:dirt_ordinary_with_turf_dry",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
