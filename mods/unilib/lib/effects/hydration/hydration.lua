---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hydration.lua
--      Set up hydration/thirst. Code adapted from the "thirsty" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- When hydration is enabled (unilib.setting.thirst_enable_flag), the player's hydration
--      continuously decreases (thirst continually increases) until the HUD is empty, and then
--      health points start decreasing. Thirst increases at a steady rate, independent of any
--      activities the player is performing (unlike hunger)
-- Players can re-hydrate themselves using any of the following methods:
--      1. Stand in water (without moving)
--      2. Use a compatible container (such as the wooden bowl, "unilib:utensil_bowl_wooden",
--          "unilib:vessel_glass_empty") to scoop up and drink water
--      3. Fill a canteen (e.g. "unilib:item_canteen_steel") with water, and drink from it
--          occasionally
--      4. Place a drinking fountain in the world. Either drink from it directly, or use it to
--          re-fill a canteen
--      5. Place a canteen, a water extractor ("unilib:device_extractor_water") and a water
--          injector ("unilib:device_injector_water") in your inventory. The extractor slowly
--          re-fills the canteen. The injector slowly empties the canteen to prevent your hydration
--          from decreasing

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.hydration = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up hydration/thirst
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.thirst_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/hydration/hydration_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/hydration/hydration_bu.lua")
end
