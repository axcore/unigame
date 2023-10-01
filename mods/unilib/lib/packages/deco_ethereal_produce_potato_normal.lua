---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_potato_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_potato_normal.init()

    return {
        description = "Normal potato as decoration",
        depends = {"biome_ethereal_rainforest", "produce_potato_normal"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_rainforest"},
    }

end

function unilib.pkg.deco_ethereal_produce_potato_normal.exec()

    unilib.register_decoration("ethereal_produce_potato_normal", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_potato_normal_grow_3",

        fill_ratio = 0.035,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_produce_potato_normal.post()

    unilib.register_decoration_now("ethereal_produce_potato_normal", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_rainforest",
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf_rainforest",
        },
        y_max = 100,
        y_min = 1,
    })

end

