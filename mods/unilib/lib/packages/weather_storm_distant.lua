---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_storm_distant = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_storm_distant.init()

    return {
        description = "Distant thunder (weather effect)",
        depends = "weather_prototype_storm",
    }

end

function unilib.pkg.weather_storm_distant.exec()

    -- N.B. Unlike the other storm effects, this one has no precipitation and no lightning bolts
    --      (just a nice sound effect)
    unilib.atmosphere.register_weather("unilib_storm_distant", "storm", {
        description = S("Distant storm"),

        chance = 3,
        cloud_density = 0,
        max_light = 14,
        sky_colour_list = {"#7299A8", "#222C33"},
        sound_table = {
            default = "unilib_weather_storm_distant",
            cover = "unilib_weather_storm_distant_cover",
        },
        tag_list = {"random", "storm"},
    })

end
