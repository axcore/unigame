---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- alarms_bu.lua
--      Backups for shared functions in ../lib/effects/alarms/alarms_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"alarms\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.alarms.cancel_expired_alarm(...)
    unilib.utils.show_warning(msg, "unilib.alarms.cancel_expired_alarm")
end
