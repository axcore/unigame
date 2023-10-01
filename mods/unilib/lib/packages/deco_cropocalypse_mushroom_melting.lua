---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_mushroom_melting = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_mushroom_melting.init()

    return {
        description = "Melting mushroom as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "mushroom_melting"},
    }

end

function unilib.pkg.deco_cropocalypse_mushroom_melting.post()

    unilib.register_decoration_now("cropocalypse_mushroom_melting", nil, {
        -- From cropocalypse/glowing_mushrooms.lua
        -- Completes decoration in package "mushroom_melting"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
