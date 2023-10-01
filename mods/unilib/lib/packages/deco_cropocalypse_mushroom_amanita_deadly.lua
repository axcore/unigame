---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_mushroom_amanita_deadly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_mushroom_amanita_deadly.init()

    return {
        description = "Deadly amanita mushroom as decoration",
        depends = {"biome_grave_graveyard", "mushroom_amanita_deadly"},
    }

end

function unilib.pkg.deco_cropocalypse_mushroom_amanita_deadly.post()

    unilib.register_decoration_now("cropocalypse_mushroom_amanita_deadly", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "mushroom_amanita_deadly"
        biomes = "grave_graveyard",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
