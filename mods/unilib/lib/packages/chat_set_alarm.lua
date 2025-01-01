---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_set_alarm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_set_alarm.init()

    return {
        description = "Chat command /set_alarm",
        notes = "Sets a daily alarm which rings at HH:MM (24-hour clock)",
        depends = "shared_chat_alarm",
    }

end

function unilib.pkg.chat_set_alarm.exec()

    core.register_chatcommand("set_alarm", {
        params = "<time>",
        description = S("Sets a daily alarm which rings at HH:MM (24-hour clock)"),

        func = function(name, param)

            if not unilib.setting.alarm_enable_flag then
                return false, unilib.pkg.shared_chat_alarm.unavailable_msg
            elseif not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            elseif param == nil or param == "" then
                return false, unilib.pkg.shared_chat_alarm.invalid_time_msg
            end

            -- Allow both H:MM and HH:MM
            if string.find(param, "^%d:%d%d$") then
                param = "0" .. param
            end

            if not string.find(param, "^%d%d:%d%d$") then
                return false, unilib.pkg.shared_chat_alarm.invalid_time_msg
            end

            unilib.utils.set_player_attribute(core.get_player_by_name(name), "alarm", param)
            unilib.alarms.cancel_expired_alarm(name)

            local current_time, _ = unilib.utils.get_clock_time()
            return true,
                    S("Daily alarm set for the time @1 (current time is @2)", param, current_time)

        end,
    })

end
