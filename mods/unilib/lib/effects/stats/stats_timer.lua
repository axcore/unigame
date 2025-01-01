---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats_timer.lua
--      Generates a timer to save biographical and activity statistics reguarlarly
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Update each player's connection time every second. Update the tick values to reduce the load on
--      the server
local short_timer = 0
local short_timer_tick = 1
-- Save statistics every minute
local long_timer = 0
local long_timer_tick = 60

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Save statistics regularly, and update player connection times
core.register_globalstep(function(dtime)

    short_timer = short_timer + dtime
    long_timer = long_timer + dtime

    if short_timer >= short_timer_tick then

        if unilib.setting.stats_bio_flag then

            for _, player in ipairs(core.get_connected_players()) do

                unilib.stats.increase_bio_stat(
                    player:get_player_name(), "connected_session", short_timer
                )

                unilib.stats.increase_bio_stat(
                    player:get_player_name(), "connected_total", short_timer
                )

            end

        end

        short_timer = 0

    end

    if long_timer >= long_timer_tick then

        unilib.stats.save_activity_stats()
        unilib.stats.save_bio_stats()
        long_timer = 0

    end

end)
