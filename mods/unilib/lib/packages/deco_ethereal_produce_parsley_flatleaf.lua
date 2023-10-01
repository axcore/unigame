---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_parsley_flatleaf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_parsley_flatleaf.init()

    return {
        description = "Flat-leaf parsley as decoration",
        depends = {
            "biome_ethereal_mediterranean",
            "dirt_ordinary_with_turf_grove",
            "produce_parsley_flatleaf",
        },
    }

end

function unilib.pkg.deco_ethereal_produce_parsley_flatleaf.exec()

    unilib.register_decoration("ethereal_produce_parsley_flatleaf", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_parsley_flatleaf_grow_3",

        fill_ratio = 0.025,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_produce_parsley_flatleaf.post()

    unilib.register_decoration_now("ethereal_produce_parsley_flatleaf", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_mediterranean",
        place_on = "unilib:dirt_ordinary_with_turf_grove",
        y_max = 100,
        y_min = 1,
    })

end

