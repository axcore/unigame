---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_mushroom_red.init()

    return {
        description = "Red mushroom as decoration",
        depends = {"biome_ethereal_mushroom", "dirt_ordinary_with_turf_mushroom", "mushroom_red"},
    }

end

function unilib.pkg.deco_ethereal_mushroom_red.exec()

    unilib.register_decoration("ethereal_mushroom_red", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_red",

        fill_ratio = 0.01,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_mushroom_red.post()

    unilib.register_decoration_now("ethereal_mushroom_red", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_mushroom",
        place_on = "unilib:dirt_ordinary_with_turf_mushroom",
        y_max = 100,
        y_min = 1,
    })

end

