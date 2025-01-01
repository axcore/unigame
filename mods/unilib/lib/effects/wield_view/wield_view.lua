---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wield_view.lua
--      Set up the wield_view effect. Code adapted from 3d_armor/wieldview
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

--unilib.wield_view = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up the wield_view effect (which requires some form of armour, for example by using the
--      "armour" remix)
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.wield_view_enable_flag) and
        unilib.armour.active_flag then
    dofile(unilib.core.path_mod .. "/lib/effects/wield_view/wield_view_base.lua")
end
