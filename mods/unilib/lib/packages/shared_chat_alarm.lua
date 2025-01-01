---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_alarm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_alarm.invalid_time_msg = S("Please specify an alarm time, in the form HH:MM")
unilib.pkg.shared_chat_alarm.unavailable_msg = S(
    "Daily alarms are not available, please check your Minetest settings"
)

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_alarm.init()

    return {
        description = "Shared functions for chat command packages for player alarms",
    }

end
