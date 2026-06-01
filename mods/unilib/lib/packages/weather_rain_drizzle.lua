---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_rain_drizzle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local accel = -15
local average_height = 16
local drift_factor = 0.4
local expiry_time = 5
local horizontal_range = 16
local particle_density = 256 / 8
local particle_size = 3
local velocity_range = 0.2

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
            playername = pname,
            pos = {
                x = pos.x - horizontal_range + math.random(0, (horizontal_range * 2)),
                y = pos.y + ((math.random() + 0.5) * average_height),
                z = pos.z - horizontal_range + math.random(0, (horizontal_range * 2)),
            },
            size = math.random(particle_size),
            texture = "unilib_weather_rain_light.png",
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

function unilib.pkg.weather_rain_drizzle.init()

    return {
        description = "Drizzling rain (weather effect)",
        depends = "weather_prototype_rain",
    }

end

function unilib.pkg.weather_rain_drizzle.exec()

    -- N.B. Unlike the other rain effects, this one just uses the "regular" skybox colour
    unilib.atmosphere.register_weather("unilib_rain_drizzle", "rain", {
        description = S("Drizzle"),

        chance = 5,
        max_light = 14,
        particle_func = do_particle,
        sound_table = {
            default = "unilib_weather_rain_drizzle",
            cover = "unilib_weather_rain_drizzle_cover",
        },
        tag_list = {"rain", "random"},
    })

end
