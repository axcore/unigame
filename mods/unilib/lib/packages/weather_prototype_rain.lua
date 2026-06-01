---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_prototype_rain = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_prototype_rain.init()

    return {
        description = "Weather prototype for rain",
    }

end

function unilib.pkg.weather_prototype_rain.exec()

    unilib.atmosphere.register_weather_prototype("rain", {
        description = S("Rain"),
        -- (Lower probability at lower temperatures, to make snow more probable)
        heat_min_prob = 0.3,
        heat_max_prob = 0.6,
        -- (High probability at high humidity)
        humid_min_prob = 0.2,
        humid_max_prob = 0.8,
        -- (No variation by elevation)
        height_min_prob = 0.5,
        height_max_prob = 0.5,

        noise_table = {
            lacunarity = 2.0,
            octaves = 3,
            offset = 0,
            persistence = 0.5,
            scale = 1,
            spread = {x = 100, y = 100, z = 100},
            seed = 102,
        },
    })

end
