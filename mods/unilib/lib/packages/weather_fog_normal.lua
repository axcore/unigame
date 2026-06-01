---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_fog_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_fog_normal.init()

    return {
        description = "Normal fog (weather effect)",
        depends = "weather_prototype_default",
    }

end

function unilib.pkg.weather_fog_normal.exec()

    unilib.atmosphere.register_weather("unilib_fog_normal", "default", {
        description = S("Normal fog"),

        chance = 3,
        fog_far = 50,
        fog_near = 0.05,
        fog_probability = 1,
        tag_list = {"fog", "random"},
    })

end
