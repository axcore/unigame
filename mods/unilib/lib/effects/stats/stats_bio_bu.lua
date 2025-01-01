---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats_bio_bu.lua
--      Backups for shared functions in ../lib/effects/stats/stats_bio_base_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"stats\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.stats.add_player_event(...)
    unilib.utils.show_warning(msg, "unilib.stats.add_player_event")
end

function unilib.stats.delete_player_event(...)
    unilib.utils.show_warning(msg, "unilib.stats.delete_player_event")
end
