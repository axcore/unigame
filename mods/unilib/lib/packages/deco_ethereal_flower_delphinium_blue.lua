---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_delphinium_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_delphinium_blue.init()

    return {
        description = "Blue delphinium as decoration",
        depends = "flower_delphinium_blue",
        at_least_one = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_grove",
            "dirt_ordinary_with_turf_prairie",
        },
    }

end

function unilib.pkg.deco_ethereal_flower_delphinium_blue.post()

    unilib.register_decoration_complete(
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "flower_delphinium_blue"
        "bakedclay_flower_delphinium_blue",
        "ethereal_flower_delphinium_blue",
        {
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_grove",
                "unilib:dirt_ordinary_with_turf_prairie",
            },
            y_max = 90,
            y_min = 10,
        }
    )

end

