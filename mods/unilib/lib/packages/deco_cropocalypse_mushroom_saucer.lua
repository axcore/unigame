---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_mushroom_saucer = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_mushroom_saucer.init()

    return {
        description = "Saucer mushroom as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "mushroom_saucer"},
    }

end

function unilib.pkg.deco_cropocalypse_mushroom_saucer.post()

    unilib.register_decoration_now("cropocalypse_mushroom_saucer", nil, {
        -- From cropocalypse/glowing_mushrooms.lua
        -- Completes decoration in package "mushroom_saucer"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
