---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_cloud_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_cloud_light.init()

    return {
        description = "Light cloud (weather effect)",
        depends = "weather_prototype_default",
    }

end

function unilib.pkg.weather_cloud_light.exec()

    unilib.atmosphere.register_weather("unilib_cloud_light", "default", {
        description = S("Light cloud"),

        chance = 5,
        cloud_density = 0.6,
        max_light = 13,
        tag_list = {"cloud", "random"},
    })

end
