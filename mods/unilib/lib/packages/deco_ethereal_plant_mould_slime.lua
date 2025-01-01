---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_mould_slime = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_mould_slime.init()

    return {
        description = "Slime mould as decoration",
        depends = {"biome_ethereal_mushroom", "plant_mould_slime", "sand_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_plant_mould_slime.post()

    unilib.register_decoration_complete("ethereal_plant_mould_slime", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "plant_mould_slime"
        biomes = "ethereal_mushroom_ocean",
        place_on = "unilib:sand_ordinary",
        y_max = 6,
        y_min = 2,
    })

end
