---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- alarms_cmds.lua
--      Set up chat commands for player alarms
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local invalid_time_msg = S("Please specify an alarm time, in the form HH:MM")
local unavailable_msg = S("Daily alarms are not available, please check your Minetest settings")

---------------------------------------------------------------------------------------------------
-- /set_alarm: Sets a daily alarm which rings at HH:MM (24-hour clock)
-- /cancel_alarm: Cancels the daily alarm
-- /show_alarm: Shows the current daily alarm (if any)
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("set_alarm", {
    params = "<time>",
    description = S("Sets a daily alarm which rings at HH:MM (24-hour clock)"),

    func = function(name, param)

        if not unilib.alarm_enable_flag then
            return false, unavailable_msg
        elseif not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        elseif param == nil or param == "" then
            return false, invalid_time_msg
        end

        -- Allow both H:MM and HH:MM
        if string.find(param, "^%d:%d%d$") then
            param = "0" .. param
        end

        if not string.find(param, "^%d%d:%d%d$") then
            return false, invalid_time_msg
        end

        unilib.set_player_attribute(minetest.get_player_by_name(name), "alarm", param)
        unilib.cancel_expired_alarm(name)

        local current_time, _ = unilib.get_clock_time()
        return true, S("Daily alarm set for the time @1 (current time is @2)", param, current_time)

    end,
})

minetest.register_chatcommand("cancel_alarm", {
    params = "",
    description = S("Cancels the daily alarm"),

    func = function(name, param)

        if not unilib.alarm_enable_flag then
            return false, unavailable_msg
        elseif not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local alarm = unilib.get_player_attribute(minetest.get_player_by_name(name), "alarm")
        if alarm == nil or alarm == "" then
            return false, S("Your daily alarm is not set")
        end

        unilib.set_player_attribute(minetest.get_player_by_name(name), "alarm", "")
        unilib.cancel_expired_alarm(name)

        local current_time, _ = unilib.get_clock_time()
        return true, S("Daily alarm cancelled")

    end,
})

minetest.register_chatcommand("show_alarm", {
    params = "",
    description = S("Shows the current daily alarm (if any)"),

    func = function(name, param)

        if not unilib.alarm_enable_flag then
            return false, unavailable_msg
        elseif not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local alarm = unilib.get_player_attribute(minetest.get_player_by_name(name), "alarm")
        if alarm == nil or alarm == "" then
            return false, S("Your daily alarm is not set")
        end

        local current_time, _ = unilib.get_clock_time()
        return true, S("Your daily alarm is set to @1 (current time is @2)", alarm, current_time)

    end,
})
