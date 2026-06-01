---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards.lua
--      Set up player awards (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.awards = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up player awards
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.awards_enable_flag) then

    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_timer.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_base.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_formspec.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_monitors.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_triggers.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_utils.lua")

else

    dofile(unilib.core.path_mod .. "/lib/effects/awards/awards_bu.lua")

end
