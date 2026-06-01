---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_snow_special = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

-- Flag set to true, in order to place snow on the ground; use false to reduce the load on system
--      resources (this was a setting, not a local variable, in the original code)
local ground_snow_flag = true

-- Set to world's water level. Particles are timed to disappear at this y. Particles do not spawn
--      when player's head is below this y
local y_limit = 1
-- Time scale for precipitation variation in minutes
local precip_time = 6
-- Precipitation offset, higher = rains more often
local precip_offset = -0.4
-- Globalstep cycle (seconds); in original code, value was 0.5
local gs_cycle = 1
-- Snowflakes per cycle
local flake_rate = 32
-- Whether particles collide with nodes
local collide_flag = false
-- Clouds RGB value at night
local night_rgb = 39
-- Clouds RGB value in daytime
local day_rgb = 175
-- Max temperature; was 35 in the original code. Calls to the shared function below can modify it
local max_temp = 35
-- A table of biomes; if specified, precipitation is only possible in these biomes (and even then,
--      only when the usual temperature/humidity calculations below permit it)
-- Note that the cloudy sky effect is not limited to this biome set
local biome_table = {}
local all_biomes_flag = true

local diff_rgb = day_rgb - night_rgb
local grad = 14 / 95
local y_int = 1496 / 95
local timer = 0

local np_prec_table = {
    lacunarity = 2.0,
    octaves = 1,
    offset = 0,
    persist = 0,
    scale = 1,
    seed = 813,
    spread = {x = precip_time, y = precip_time, z = precip_time},
}

-- These 2 must match biome heat and humidity noise parameters for a world
local np_temp_table = {
    lacunarity = 2.0,
    octaves = 3,
    offset = 50,
    persist = 0.5,
    scale = 50,
    seed = 5349,
    spread = {x = 1000, y = 1000, z = 1000},
}

local np_humid_table = {
    lacunarity = 2.0,
    octaves = 3,
    offset = 50,
    persist = 0.5,
    scale = 50,
    seed = 842,
    spread = {x = 1000, y = 1000, z = 1000},
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_snow_special.set_max_temp(value)

    -- Original to unilib
    -- By default, this package acts at temperatures lower than 35; other packages can change this
    --      value by calling this function from their .exec() functions
    --
    -- Args:
    --      value (int): The maximum temperature at which this package acts; values outside the
    --          range -100 to +100 are ignored

    if tonumber(value) == value and value <= 100 and value >= 100 then
        max_temp = value
    end

end

function unilib.pkg.weather_snow_special.set_exclusive_biome(biome_name)

    -- Original to unilib
    -- By default, precipitation can occur in any biome with suitable temperature/humidity. When
    --      this doesn't fit the theme of a game, this function can be called to specify the biomes
    --      in which precipitation is allowed
    -- Note that the cloudy sky effect is not limited to this biome set
    --
    -- Args:
    --      biome_name (str): e.g. "default_icesheet"

    biome_table[biome_name] = true
    all_biomes_flag = false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_snow_special.init()

    return {
        description = "Falling snowflakes",
        notes = "This package has been adapted from the \"snow\" mod. It is not part of unilib's" ..
                " own weather system. When this package is loaded, snowflakes may appear in any" ..
                " suitable biome, regardless of whether unilib's weather settings are disabled" ..
                " or not",
        depends = "shared_snow",
    }

end

function unilib.pkg.weather_snow_special.exec()

    -- The code imported from the "snow" mod does this:
    --      - If "precip_flag" is true (depends on both temperature and humidity), the skybox
    --          changes to appear overcast
    --      - If "freeze_flag" is true (when temperature is lower than 35), snowflake particles fall
    --          from the sky, occasionally placing ordinary snow on the ground (or increasing the
    --          height of an existing ordinary snow node)
    -- Note that some biomes from the "snow" mod (for example, the "biome_snow_normal" package)
    --      don't satisfy these conditions, so the sky is not overcast, and snow does not fall

    core.register_globalstep(function(dtime)

        timer = timer + dtime
        if timer < gs_cycle then
            return
        end

        timer = 0

        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            local pos_player = player:get_pos()

            -- Precipitation when swimming
            local ppos_y = math.floor(pos_player.y) + 2
            if ppos_y >= y_limit - 2 then

                local ppos_x = math.floor(pos_player.x)
                local ppos_z = math.floor(pos_player.z)
                local ppos = {x = ppos_x, y = ppos_y, z = ppos_z}

                local nobj_temp = core.get_perlin(np_temp_table)
                local nobj_humid = core.get_perlin(np_humid_table)
                local nobj_prec = core.get_perlin(np_prec_table)

                local nval_temp = nobj_temp:get_2d({x = ppos_x, y = ppos_z})
                local nval_humid = nobj_humid:get_2d({x = ppos_x, y = ppos_z})
                local nval_prec = nobj_prec:get_2d({x = (os.clock() / 60), y = 0})

                -- Biome system: Frozen biomes below heat 35 (by default), deserts below line
                --      14 * t - 95 * h = -1496
                -- h = (14 * t + 1496) / 95
                -- h = 14/95 * t + 1496/95
                --      ...where 14/95 is gradient and 1496/95 is y intersection
                -- h - 14/95 t = 1496/95 y intersection
                -- So area above line is
                -- h - 14/95 t > 1496/95
                local freeze_flag = nval_temp < max_temp
                local precip_flag =
                        nval_prec < (((nval_humid - 50) / 50) + precip_offset) and
                        (nval_humid - (grad * nval_temp)) > y_int

                -- Check if player is outside
                local outside_flag = core.get_node_light(ppos, 0.5) == 15
                -- Get player biome
                local biome_name = core.get_biome_name(core.get_biome_data(pos_player).biome)

                -- Occasionally reset player sky
                if math.random() < 0.1 then

                    if precip_flag then

                        -- Set overcast sky
                        local sval
                        local time = core.get_timeofday()
                        if time >= 0.5 then
                            time = 1 - time
                        end

                        -- Sky brightness transitions:
                        -- First transition (24000 -) 4500, (1 -) 0.1875
                        -- Last transition (24000 -) 5750, (1 -) 0.2396
                        if time <= 0.1875 then
                            sval = night_rgb
                        elseif time >= 0.2396 then
                            sval = day_rgb
                        else
                            sval = math.floor(night_rgb + ((time - 0.1875) / 0.0521) * diff_rgb)
                        end

                        -- Set sky to overcast blueish-grey
                        player:set_sky({
                            base_color = {r = sval, g = sval, b = sval + 16, a = 255},
                            type = "plain",
                        })

                    else

                        -- Reset sky to normal
                        player:set_sky({type = "regular"})

                    end

                end

                if precip_flag and
                        freeze_flag and
                        outside_flag and
                        (all_biomes_flag or biome_table[biome_name]) then

                    -- Place snow on the ground at a random nearby position
                    if ground_snow_flag then

                        local rpos = {
                            x = ppos_x - 24 + math.random(0, 48),
                            y = ppos_y + 12,
                            z = ppos_z - 24 + math.random(0, 48),
                        }

                        -- (On success, the function returns rpos adjusted to the ground level)
                        local gpos = unilib.pkg.shared_snow.can_place_snow_on_ground(rpos)
                        if gpos then
                            unilib.pkg.shared_snow.place_snow_on_ground(gpos)
                        end

                    end

                    -- Snowflakes as precipitation
                    local exp_time = math.min(((ppos_y + 12 - y_limit) / 2), 9)
                    for _ = 1, flake_rate do

                        core.add_particle({
                            acceleration = {x = 0, y = 0, z = 0},
                            collisiondetection = collide_flag,
                            collision_removal = true,
                            expirationtime = exp_time,
                            playername = pname,
                            pos = {
                                x = ppos_x - 24 + math.random(0, 48),
                                y = ppos_y + 12,
                                z = ppos_z - 24 + math.random(0, 48),
                            },
                            size = 2.8,
                            texture = "unilib_weather_snow_" .. math.random(1, 12) .. ".png",
                            velocity = {
                                x = (-20 + math.random(0, 40)) / 100,
                                y = -2.0,
                                z = (-20 + math.random(0, 40)) / 100,
                            },
                            vertical = false,
                        })

                    end

                end

            end

        end

    end)

end
