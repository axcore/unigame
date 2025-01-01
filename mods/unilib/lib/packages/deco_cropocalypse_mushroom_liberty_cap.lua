---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_mushroom_liberty_cap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_mushroom_liberty_cap.init()

    return {
        description = "Liberty cap mushroom as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "mushroom_liberty_cap"},
    }

end

function unilib.pkg.deco_cropocalypse_mushroom_liberty_cap.post()

    unilib.register_decoration_complete("cropocalypse_mushroom_liberty_cap", nil, {
        -- From cropocalypse/glowing_mushrooms.lua
        -- Completes decoration in package "mushroom_liberty_cap"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
