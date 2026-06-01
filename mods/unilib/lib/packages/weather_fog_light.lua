---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_fog_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_fog_light.init()

    return {
        description = "Light fog (weather effect)",
        depends = "weather_prototype_default",
    }

end

function unilib.pkg.weather_fog_light.exec()

    unilib.atmosphere.register_weather("unilib_fog_light", "default", {
        description = S("Light fog"),

        chance = 5,
        fog_far = 100,
        fog_near = 0.25,
        fog_probability = 1,
        tag_list = {"fog", "random"},
    })

end
