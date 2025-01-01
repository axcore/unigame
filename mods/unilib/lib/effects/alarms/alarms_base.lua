---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- alarms.lua
--      Set up player alarms (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Update the tick value to reduce the load on the server (at the expense of making alarms less
--      accurate)
local timer = 0
local timer_tick = 1

-- Every player can set one alarm, which "rings" daily. This table contains every (connected) player
--      who alarm has already rung on the current game day
local player_table = {}
-- The number of the current game day. When the next day happens, player_table is reset, allowing
--      all of its alarms to "ring" again during the day
local epoch_day = core.get_day_count() or 0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function activate_alarm(pname, epoch_day, hour, minute)

    local year, month, day = unilib.calendars.convert_minetest_epoch(epoch_day)

    local date_string = unilib.calendars.format_date(year, month, day, epoch_day, hour, minute)
    core.chat_send_player(pname, S("Today is @1.", tostring(date_string)))
    core.sound_play("unilib_alarm", {to_player = pname, gain = 1.0}, true)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.alarms.cancel_expired_alarm(pname)

    -- Called by chat commands after the player changes their alarm time
    -- Doing this allows the alarm to "ring" twice in a day (if the new time has not occured yet)

    player_table[pname] = nil

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_globalstep(function(dtime)

    timer = timer + dtime
    if timer >= timer_tick then

        timer = 0

        local new_epoch_day = core.get_day_count()
        if new_epoch_day > epoch_day then

            -- New game day; all player alarms can ring again
            epoch_day = new_epoch_day
            player_table = {}

        end

        local game_time, game_hour, game_minute = unilib.utils.get_clock_time()
        local game_total = (game_hour * 60) + game_minute

        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if player_table[pname] == nil then

                local alarm_time, alarm_hour, alarm_minute, alarm_total

                alarm_time = unilib.utils.get_player_attribute(player, "alarm")
                if alarm_time ~= nil and alarm_time ~= "" then

                    alarm_hour = tonumber(string.sub(alarm_time, 1, 2))
                    alarm_minute = tonumber(string.sub(alarm_time, 4, 5))
                    alarm_total = (alarm_hour * 60) + alarm_minute

                    -- Not all combinations of HH:MM actually occur in-game, and a server might be
                    --      subject to some lag, so we have to allow a grace period of 15 in-game
                    --      minutes
                    if game_total >= alarm_total and game_total <= (alarm_total + 15) then

                        activate_alarm(pname, new_epoch_day, game_hour, game_minute)
                        player_table[pname] = true

                    end

                end

            end

        end

    end

end)
