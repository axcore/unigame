---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- identify.lua
--      Set up the HUD announcement identifying the pointed-at node. Code adapted from the
--          "what_is_this_uwu"/"what_is_this_owo" mods, but includes a lot of original code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.identify = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up the HUD window identifying the pointed-at node
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.announce_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/identify/identify_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/identify/identify_bu.lua")
end
