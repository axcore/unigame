---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.slopes = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up natural slopes
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.slopes_enable_flag) then

    dofile(unilib.core.path_mod .. "/lib/effects/slopes/slopes_accessors.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/slopes/slopes_base.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/slopes/slopes_private.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/slopes/slopes_register.lua")
    dofile(unilib.core.path_mod .. "/lib/effects/slopes/slopes_update_shapes.lua")

end
