---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_cancel_alarm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_cancel_alarm.init()

    return {
        description = "Chat command /cancel_alarm",
        notes = "Cancels the daily alarm",
        depends = "shared_chat_alarm",
    }

end

function unilib.pkg.chat_cancel_alarm.exec()

    core.register_chatcommand("cancel_alarm", {
        params = "",
        description = S("Cancels the daily alarm"),

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not unilib.setting.alarm_enable_flag then
                return false, unilib.pkg.shared_chat_alarm.unavailable_msg
            elseif not player then
                return false, unilib.constant.chat_offline_msg
            end

            local alarm = unilib.utils.get_player_attribute(player, "alarm")
            if alarm == nil or alarm == "" then
                return false, S("Your daily alarm is not set")
            end

            unilib.utils.set_player_attribute(player, "alarm", "")
            unilib.alarms.cancel_expired_alarm(pname)

            local current_time, _ = unilib.utils.get_clock_time()
            return true, S("Daily alarm cancelled")

        end,
    })

end
