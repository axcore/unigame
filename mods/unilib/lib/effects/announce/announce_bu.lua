---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- announce_bu.lua
--      Backups for shared functions in ../lib/effects/announce/announce_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"announce\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.announce.add_long_announcement(...)
    unilib.utils.show_warning(msg, "unilib.announce.add_long_announcement")
end

function unilib.announce.add_short_announcement(...)
    unilib.utils.show_warning(msg, "unilib.announce.add_short_announcement")
end

function unilib.announce.remove_short_announcement(...)
    unilib.utils.show_warning(msg, "unilib.announce.remove_short_announcement")
end

function unilib.announce.is_long_announcement_visible(...)
    unilib.utils.show_warning(msg, "unilib.announce.is_long_announcement_visible")
end
