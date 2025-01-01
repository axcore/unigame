---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_tree_young_dead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_tree_young_dead.init()

    return {
        description = "Dead young tree as decoration",
        depends = {"biome_grave_graveyard", "tree_young_dead"},
    }

end

function unilib.pkg.deco_cropocalypse_tree_young_dead.post()

    unilib.register_decoration_complete("cropocalypse_tree_young_dead", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "tree_young_dead"
        biomes = "grave_graveyard",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
