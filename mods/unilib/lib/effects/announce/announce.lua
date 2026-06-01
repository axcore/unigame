---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- announce.lua
--      Set up the HUD window for making announcements. Code adapted from the
--          "what_is_this_uwu"/"what_is_this_owo" mods
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.announce = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up the HUD announcements
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.announce_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/announce/announce_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/announce/announce_bu.lua")
end
