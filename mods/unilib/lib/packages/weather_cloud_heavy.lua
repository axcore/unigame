---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_cloud_heavy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_cloud_heavy.init()

    return {
        description = "Heavy cloud (weather effect)",
        depends = "weather_prototype_default",
    }

end

function unilib.pkg.weather_cloud_heavy.exec()

    unilib.atmosphere.register_weather("unilib_cloud_heavy", "default", {
        description = S("Heavy cloud"),

        chance = 1,
        cloud_density = 1,
        max_light = 11,
        tag_list = {"cloud", "random"},
    })

end
