---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_hail_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local accel = -15
local average_height = 16
local drift_factor = 0.3
local expiry_time = 5
local horizontal_range = 16
local particle_density = 256 * 2
local particle_size = 3
local velocity_range = 0.2

local splash_density = 64 * 2
local splash_list = {
    "unilib_weather_hail_normal_bounce_1.png",
    "unilib_weather_hail_normal_bounce_2.png",
}

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
            texture = "unilib_weather_hail_normal.png",
            velocity = {
                x = wind_x + ((velocity_range * -1) + math.random(0, (velocity_range * 2))),
                y = accel,
                z = wind_z + ((velocity_range * -1) + math.random(0, (velocity_range * 2))),
            },
            vertical = false,
        })

    end

    if unilib.setting.atmosphere_splash_enable_flag then
        unilib.pkg.shared_weather.do_splash(pname, pos, splash_density, splash_list)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_hail_normal.init()

    return {
        description = "Normal hail (weather effect)",
        depends = {"shared_weather", "weather_prototype_rain"},
    }

end

function unilib.pkg.weather_hail_normal.exec()

    unilib.atmosphere.register_weather("unilib_hail_normal", "rain", {
        description = S("Normal hail"),

        chance = 3,
        cloud_density = 0,
        max_light = 11,
        particle_func = do_particle,
        sky_colour_list = {"#B0B0B0", "#111111"},
        sound_table = {
            default = "unilib_weather_hail_normal",
            cover = "unilib_weather_hail_normal_cover",
        },
        tag_list = {"hail", "random"},
    })

end
