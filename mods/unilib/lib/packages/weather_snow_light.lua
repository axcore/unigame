---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_snow_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local accel = -1.5
local average_height = 16
local drift_factor = 0.2
local expiry_time = 10
local horizontal_range = 16
local particle_density = 16
local particle_size = 1.6
local velocity_range = 0.2

-- Because of the overcast sky, make the snowflakes glow a little to make them visible (for
--      aesthetic purposes)
local glow_level = 2

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_particle(pname, pos, wind_speed, wind_angle)

    -- (Particles drift in the direction of the wind, if specified)
    local wind_x = 0
    local wind_z = 0
    if wind_speed and wind_angle then

        -- 1kph = 0.278 m/s; also add a drift factor since each particle's horizontal velocity is
        --      less than the actual wind speed
        local wind_speed_ms = wind_speed * 0.28 * drift_factor
        wind_x = wind_speed_ms * math.sin(wind_angle)
        wind_z = -wind_speed_ms * math.cos(wind_angle)

    end

    for i = 1, particle_density do

        core.add_particle({
            acceleration = {x = 0, y = 0, z = 0},
            collisiondetection = true,
            collision_removal = true,
            expirationtime = expiry_time,
            glow = glow_level,
            playername = pname,
            pos = {
                x = pos.x - horizontal_range + math.random(0, (horizontal_range * 2)),
                y = pos.y + ((math.random() + 0.5) * average_height),
                z = pos.z - horizontal_range + math.random(0, (horizontal_range * 2)),
            },
            size = particle_size,
            texture = "unilib_weather_snow_" .. math.random(1, 12) .. ".png",
            velocity = {
                x = wind_x + ((velocity_range * -1) + math.random(0, (velocity_range * 2))),
                y = accel,
                z = wind_z + ((velocity_range * -1) + math.random(0, (velocity_range * 2))),
            },
            vertical = false,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_snow_light.init()

    return {
        description = "Light snow (weather effect)",
        depends = "weather_prototype_snow",
    }

end

function unilib.pkg.weather_snow_light.exec()

    unilib.atmosphere.register_weather("unilib_snow_light", "snow", {
        description = S("Light snow"),

        chance = 5,
        cloud_density = 0,
        particle_func = do_particle,
        sky_colour_list = {"#BFBFBF", "#111111"},
        tag_list = {"snow", "random"},
    })

end
