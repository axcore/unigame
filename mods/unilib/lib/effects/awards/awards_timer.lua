---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_timer.lua
--      Generates a timer to save player awards data regularly
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Update each player's connection time every second. Update the tick values to reduce the load on
--      the server
local short_timer = 0
local short_timer_tick = 1
-- Save player awards data every minute
local long_timer = 0
local long_timer_tick = 60

-- Lists of (trigger) event callbacks to call when the short/long timers tick over
local short_timer_callback_list = {}
local long_timer_callback_list = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.awards.register_short_timer_callback(func)
    table.insert(short_timer_callback_list, func)
end

function unilib.awards.register_long_timer_callback(func)
    table.insert(long_timer_callback_list, func)
end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Save player awards data regularly
core.register_globalstep(function(dtime)

    short_timer = short_timer + dtime
    long_timer = long_timer + dtime

    if short_timer >= short_timer_tick then

        for _, func in ipairs(short_timer_callback_list) do
            func(dtime)
        end

        -- (no code here yet)
        short_timer = 0

    end

    if long_timer >= long_timer_tick then

        for _, func in ipairs(long_timer_callback_list) do
            func(dtime)
        end

        unilib.awards.save_player_data()
        long_timer = 0

    end

end)
