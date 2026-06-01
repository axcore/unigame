---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_snow_heavy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local accel = -3
local average_height = 16
local drift_factor = 0.2
local expiry_time = 10
local horizontal_range = 16
local particle_density = 16 * 4
local particle_size = 2
local velocity_range = 0.3

-- Because this weather effect has a low maximum light, make the snowflakes glow a little to make
--      them visible (for aesthetic purposes)
local glow_level = 3

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

function unilib.pkg.weather_snow_heavy.init()

    return {
        description = "Heavy snow (weather effect)",
        depends = "weather_prototype_snow",
        optional = {"shared_snow", "snow_ordinary"},
    }

end

function unilib.pkg.weather_snow_heavy.exec()

    local ground_func
    if unilib.global.pkg_executed_table["shared_snow"] ~= nil and
            unilib.global.pkg_executed_table["snow_ordinary"] ~= nil then
        ground_func = unilib.pkg.shared_weather.place_snowfall
    end

    unilib.atmosphere.register_weather("unilib_snow_heavy", "snow", {
        description = S("Heavy snow"),

        chance = 1,
        cloud_density = 0,
        ground_func = ground_func,
        max_light = 12,
        particle_func = do_particle,
        sky_colour_list = {"#9F9F9F", "#111111"},
        tag_list = {"snow", "random"},
    })

end
