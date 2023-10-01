---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- effects.lua
--      Set up unilib effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local path = unilib.path_mod .. "/lib/effects/"

---------------------------------------------------------------------------------------------------
-- Set up effects
---------------------------------------------------------------------------------------------------

-- Set up player alarms
dofile(path .. "alarms_effects.lua")

-- Set up calendar effects
dofile(path .. "calendar.lua")

--  Set up advanced cuisine (file already loaded, see comments in init.lua)
--dofile(path .. "cuisine.lua")

-- Set up miscellaneous debug effects
dofile(path .. "debug.lua")

-- Set up flooding and flushing effects
dofile(path .. "flooding.lua")

-- Set the hotbar size
dofile(path .. "hotbar.lua")

-- Set up hydration/thirst (file already loaded, see comments in init.lua)
--dofile(path .. "hydration.lua")

-- Set up the HUD window identifying the pointed-at node
dofile(path .. "identify.lua")

-- Set up Minecraft-style item drop/get
dofile(path .. "magnet.lua")

-- Set up hunger and sprinting fatigue
dofile(path .. "stamina.lua")

-- Set up player statistics
dofile(path .. "stats_effects.lua")

-- Set up wielded light effects
dofile(path .. "wielded_light.lua")
