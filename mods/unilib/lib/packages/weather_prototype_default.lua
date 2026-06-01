---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_prototype_default = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_prototype_default.init()

    return {
        description = "Weather prototype for all weather effects that aren't particular suited" ..
                " to certain temperatures, humidities or elevations",
    }

end

function unilib.pkg.weather_prototype_default.exec()

    unilib.atmosphere.register_weather_prototype("default", {
        description = S("Normal weather"),
        heat_min_prob = 0.6,
        heat_max_prob = 0.4,
        humid_min_prob = 0.6,
        humid_max_prob = 0.4,
        height_min_prob = 0.5,
        height_max_prob = 0.5,

        noise_table = {
            lacunarity = 2.0,
            octaves = 3,
            offset = 0,
            persistence = 0.5,
            scale = 1,
            spread = {x = 100, y = 100, z = 100},
            seed = 101,
        },
    })

end
