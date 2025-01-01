---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_alarm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_alarm.init()

    return {
        description = "Chat command /show_alarm",
        notes = "Shows the current daily alarm (if any)",
        depends = "shared_chat_alarm",
    }

end

function unilib.pkg.chat_show_alarm.exec()

    core.register_chatcommand("show_alarm", {
        params = "",
        description = S("Shows the current daily alarm (if any)"),

        func = function(name, param)

            if not unilib.setting.alarm_enable_flag then
                return false, unilib.pkg.shared_chat_alarm.unavailable_msg
            elseif not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            local alarm = unilib.utils.get_player_attribute(core.get_player_by_name(name), "alarm")
            if alarm == nil or alarm == "" then
                return false, S("Your daily alarm is not set")
            end

            local current_time, _ = unilib.utils.get_clock_time()
            return true,
                    S("Your daily alarm is set to @1 (current time is @2)", alarm, current_time)

        end,
    })

end
