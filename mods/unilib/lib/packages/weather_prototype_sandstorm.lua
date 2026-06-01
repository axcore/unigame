---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_prototype_sandstorm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_prototype_sandstorm.init()

    return {
        description = "Weather prototype for sandstorms",
    }

end

function unilib.pkg.weather_prototype_sandstorm.exec()

    unilib.atmosphere.register_weather_prototype("sandstorm", {
        description = S("Sandstorms"),
        -- (Requires hot, dry biomes)
        heat_min_prob = -2,
        heat_max_prob = 0.5,
        humid_min_prob = -2,
        humid_max_prob = 0.5,
        -- (Requires low elevations)
        height_min_prob = 1,
        height_max_prob = 0,

        noise_table = {
            lacunarity = 2.0,
            octaves = 3,
            offset = 0,
            persistence = 0.5,
            scale = 1,
            spread = {x = 100, y = 100, z = 100},
            seed = 103,
        },
    })

end
