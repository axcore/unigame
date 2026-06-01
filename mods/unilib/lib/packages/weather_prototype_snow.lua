---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_prototype_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_prototype_snow.init()

    return {
        description = "Weather prototype for snow",
    }

end

function unilib.pkg.weather_prototype_snow.exec()

    unilib.atmosphere.register_weather_prototype("snow", {
        description = S("Snow"),
        -- (Higher probability at lower temperatures)
        heat_min_prob = 0.5,
        heat_max_prob = -2,
        -- (Higher probability at higher humidity)
        humid_min_prob = 0,
        humid_max_prob = 0.5,
        -- (Higher probability at higher elevations
        height_min_prob = 0.6,
        height_max_prob = 0.4,

        noise_table = {
            lacunarity = 2.0,
            octaves = 3,
            offset = 0,
            persistence = 0.5,
            scale = 1,
            spread = {x = 100, y = 100, z = 100},
            seed = 104,
        },
    })

end
