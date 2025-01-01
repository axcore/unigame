---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- identify_bu.lua
--      Backups for shared functions in ../lib/effects/identify/identify_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"identify\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.identify.toggle_mode(...)
    unilib.utils.show_warning(msg, "unilib.identify.toggle_mode")
end
