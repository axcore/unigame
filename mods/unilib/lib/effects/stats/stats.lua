---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stats.lua
--      Set up player biographical/activity statistics (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.stats = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up player biographical/activity statistics
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.stats_bio_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/stats/stats_bio_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/stats/stats_bio_bu.lua")
end

if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.stats_activity_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/stats/stats_activity_base.lua")
end

if not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or
    unilib.setting.stats_bio_flag or
    unilib.setting.stats_activity_flag
) then
    dofile(unilib.core.path_mod .. "/lib/effects/stats/stats_timer.lua")
end
