---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_cloud_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_cloud_normal.init()

    return {
        description = "Normal cloud (weather effect)",
        depends = "weather_prototype_default",
    }

end

function unilib.pkg.weather_cloud_normal.exec()

    unilib.atmosphere.register_weather("unilib_cloud_normal", "default", {
        description = S("Normal cloud"),

        chance = 3,
        cloud_density = 0.7,
        max_light = 12,
        tag_list = {"cloud", "random"},
    })

end
