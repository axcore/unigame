---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- magnet_override_bu.lua
--      Backups for shared functions in ../lib/effects/magnet/magnet_override_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"magnet\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.magnet.can_pickup(...)
    unilib.utils.show_warning(msg, "unilib.magnet.can_pickup")
end

function unilib.magnet.before_collect(...)
    unilib.utils.show_warning(msg, "unilib.magnet.before_collect")
end

function unilib.magnet.after_collect(...)
    unilib.utils.show_warning(msg, "unilib.magnet.after_collect")
end
