---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.weather_snowflakes = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

-- Set to world's water level. Particles are timed to disappear at this y. Particles do not spawn
--      when player's head is below this y
local y_limit = 1
-- Time scale for precipitation variation in minutes
local precip_time = 6
-- Precipitation offset, higher = rains more often
local precip_offset = -0.4
-- Globalstep cycle (seconds)
local gs_cycle = 0.5
-- Snowflakes per cycle
local flake_rate = 32
-- Whether particles collide with nodes
local collide_flag = false
-- Clouds RGB value at night
local night_rgb = 39
-- Clouds RGB value in daytime
local day_rgb = 175

local diff_rgb = day_rgb - night_rgb
local grad = 14 / 95
local yint = 1496 / 95
local timer = 0

local np_prec = {
    lacunarity = 2.0,
    octaves = 1,
    offset = 0,
    persist = 0,
    scale = 1,
    seed = 813,
    spread = {x = precip_time, y = precip_time, z = precip_time},
}

-- These 2 must match biome heat and humidity noise parameters for a world
local np_temp = {
    lacunarity = 2.0,
    octaves = 3,
    offset = 50,
    persist = 0.5,
    scale = 50,
    seed = 5349,
    spread = {x = 1000, y = 1000, z = 1000},
}

local np_humid = {
    lacunarity = 2.0,
    octaves = 3,
    offset = 50,
    persist = 0.5,
    scale = 50,
    seed = 842,
    spread = {x = 1000, y = 1000, z = 1000},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function snow_fall(pos)

    local ground_y = nil
    for y = pos.y + 10, pos.y + 20, 1 do

        local n = minetest.get_node({x = pos.x, y = y, z = pos.z}).name
        if n ~= "air" and n ~= "ignore" then
            return
        end

    end

    for y = pos.y + 9, pos.y - 15, -1 do

        local n = minetest.get_node({x = pos.x, y = y, z = pos.z}).name
        if n ~= "air" and n ~= "ignore" then

            ground_y = y
            break

        end

    end

    if not ground_y then
        return
    end

    pos = {x = pos.x, y = ground_y, z = pos.z}

    unilib.pkg.shared_snow.place(pos, true)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.weather_snowflakes.init()

    return {
        description = "Falling snowflakes",
        depends = "shared_snow",
    }

end

function unilib.pkg.weather_snowflakes.exec()

    -- The code imported from the "snow" mod does this:
    --      - If "precip_flag" is true (depends on both temperature and humidity), the skybox
    --          changes to appear overcast
    --      - If "freeze_flag" is true (when temperature is lower than 35), snowflake particles fall
    --          from the sky, occasionally placing ordinary snow on the ground (or increasing the
    --          height of an existing ordinary snow node)
    -- Note that some biomes from the "snow" mod (for example, the "biome_snow_normal" package)
    --      don't satisfy these conditions, so the sky is not overcast, and snow does not fall

    minetest.register_globalstep(function(dtime)

        timer = timer + dtime
        if timer < gs_cycle then
            return
        end

        timer = 0

        for _, player in ipairs(minetest.get_connected_players()) do

            local player_name = player:get_player_name()
            local pos_player = player:get_pos()
            -- Precipitation when swimming
            local pposy = math.floor(pos_player.y) + 2

            if pposy >= y_limit - 2 then

                local pposx = math.floor(pos_player.x)
                local pposz = math.floor(pos_player.z)
                local ppos = {x = pposx, y = pposy, z = pposz}

                local nobj_temp = minetest.get_perlin(np_temp)
                local nobj_humid = minetest.get_perlin(np_humid)
                local nobj_prec = minetest.get_perlin(np_prec)

                local nval_temp = nobj_temp:get_2d({x = pposx, y = pposz})
                local nval_humid = nobj_humid:get_2d({x = pposx, y = pposz})
                local nval_prec = nobj_prec:get_2d({x = os.clock() / 60, y = 0})

                -- Biome system: Frozen biomes below heat 35,
                --      deserts below line 14 * t - 95 * h = -1496
                -- h = (14 * t + 1496) / 95
                -- h = 14/95 * t + 1496/95
                --  where 14/95 is gradient and 1496/95 is y intersection
                -- h - 14/95 t = 1496/95 y intersection
                -- So area above line is
                -- h - 14/95 t > 1496/95
                local freeze_flag = nval_temp < 35
                local precip_flag = nval_prec < (nval_humid - 50) / 50 + precip_offset and
                        nval_humid - grad * nval_temp > yint

                -- Check if player is outside
                local outside_flag = minetest.get_node_light(ppos, 0.5) == 15

                -- Occasionally reset player sky
                if math.random() < 0.1 then

                    if precip_flag then

                        -- Set overcast sky
                        local sval
                        local time = minetest.get_timeofday()
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

                        -- Set sky to overcast bluish-grey
                        player:set_sky({
                            base_color = {r = sval, g = sval, b = sval + 16, a = 255},
                            type = "plain",
                        })

                    else

                        -- Reset sky to normal
                        player:set_sky({type = "regular"})

                    end

                end

                if precip_flag and outside_flag then

                    -- Precipitation
                    if freeze_flag then

                        -- Snowfall
                        local extime = math.min((pposy + 12 - y_limit) / 2, 9)

                        local x, y, z = pposx - 24 + math.random(0, 48),
                                pposy + 12,
                                pposz - 24 + math.random(0, 48)

                        if not unilib.snow_reduce_snowflakes_flag then

                            snow_fall(
                                {x = x, y = y, z = z},
                                true
                            )

                        end

                        for _ = 1, flake_rate do

                            x, y, z = pposx - 24 + math.random(0, 48),
                                    pposy + 12,
                                    pposz - 24 + math.random(0, 48)

                            minetest.add_particle({
                                acceleration = {x = 0, y = 0, z = 0},
                                collisiondetection = collide_flag,
                                collision_removal = true,
                                expirationtime = extime,
                                playername = player_name,
                                pos = {x = x, y = y, z = z},
                                size = 2.8,
                                texture = "unilib_weather_snowflake_" .. math.random(1, 12) ..
                                        ".png",
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

        end

    end)

end
