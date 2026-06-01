---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_sandstorm_heavy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local average_height = 16
local drift_factor = 0.2
local expiry_time = 5
local horizontal_range = 4
local particle_density = 32 * 4
local particle_size = 1

-- Horizontal and vertical velocity ranges; the "speed_factor" guarantees a fractional value
local horizontal_max = 3 * 2
local vertical_max = 0.3 * 2
local speed_factor = 10
local vel_h1 = (horizontal_max * speed_factor) * -1
local vel_h2 = horizontal_max * speed_factor
local vel_v1 = (horizontal_max * speed_factor) * -1
local vel_v2 = horizontal_max * speed_factor

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
                y = pos.y + ((math.random() - 0.5) * average_height),
                z = pos.z - horizontal_range + math.random(0, (horizontal_range * 2)),
            },
            -- (Since the range is 0-1, guarantee a minimum particle size)
            size = math.random(particle_size) + 0.1,
            texture = "unilib_weather_sandstorm_" .. math.random(1, 3) .. ".png",
            velocity = {
                x = wind_x + (math.random(vel_h1, vel_h2) / speed_factor),
                y = math.random(vel_v1, vel_v2) / speed_factor,
                z = wind_z + (math.random(vel_h1, vel_h2) / speed_factor),
            },
            vertical = false,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_sandstorm_heavy.init()

    return {
        description = "Heavy sandstorm (weather effect)",
        depends = "weather_prototype_sandstorm",
    }

end

function unilib.pkg.weather_sandstorm_heavy.exec()

    unilib.atmosphere.register_weather("unilib_sandstorm_heavy", "sandstorm", {
        description = S("Heavy sandstorm"),

        chance = 1,
        cloud_density = 0,
        -- N.B. The sandstorm effect looks better if a neutral fog colour is used; but you can
        --      uncomment this line, if you prefer a matching fog colour
--      fog_colour = "#FF914E70",
        fog_far = 10,
        fog_near = 0,
        fog_probability = 1,
        max_wind_speed = 60,
        min_time = 300,
        min_wind_speed = 20,
        particle_func = do_particle,
        -- N.B. 80% and 10% lightness, compared to .fog_colour
        sky_colour_list = {"#CC743E", "#1A0F08"},
        sound_table = {
            default = "unilib_weather_sandstorm_heavy",
            cover = "unilib_weather_sandstorm_cover",
        },
        tag_list = {"random", "sandstorm"},
    })

end
