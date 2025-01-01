---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_thistle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_thistle.init()

    return {
        description = "Thistle as decoration",
        depends = "flower_thistle",
        at_least_one = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_bamboo",
            "dirt_ordinary_with_turf_grove",
            "dirt_ordinary_with_turf_prairie",
        },
    }

end

function unilib.pkg.deco_ethereal_flower_thistle.exec()

    unilib.register_decoration_generic("ethereal_flower_thistle", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:flower_thistle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.004,
            seed = 7134,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_flower_thistle.post()

    unilib.register_decoration_complete("ethereal_flower_thistle", nil, {
        -- From ethereal-ng/decor.lua
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_bamboo",
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 90,
        y_min = 15,
    })

end

