---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cmds.lua
--      Set up unilib chat commands
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local path = unilib.path_mod .. "/lib/cmds/"

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- For a list of privileges associated with unilib chat commands, see ../lib/system/privs.lua

---------------------------------------------------------------------------------------------------
-- Set up chat commands
---------------------------------------------------------------------------------------------------

-- Set up chat commands for player alarms
dofile(path .. "alarms_cmds.lua")

-- Set up chat commands for detecting/finding biomes
dofile(path .. "biomes.lua")

-- Set up chat commands for checking things
dofile(path .. "check.lua")

-- Set up chat commands for checking recipe conflicts
dofile(path .. "conflict.lua")

-- Set up chat commands for converting original items into unilib items, and vice-versa
dofile(path .. "convert.lua")

-- Set up chat commands for health, stamina, hydration and advanced cuisine
dofile(path .. "cuisine.lua")

-- Set up chat commands for dumping definitions (of nodes, etc) to the chat window
dofile(path .. "dump.lua")

-- Set up chat commands for identifying the pointed node
dofile(path .. "identify.lua")

-- Set up chat commands for listing registered things
dofile(path .. "list.lua")

-- Set up chat commands for checking recipes with missing items
dofile(path .. "missing.lua")

-- Set up chat commands for showing various data
dofile(path .. "show.lua")

-- Set up chat commands for showing player statistics
dofile(path .. "stats_cmds.lua")

-- Set up chat commands for teleporting to arbitrary locations
dofile(path .. "teleport.lua")

-- Set up chat commands for testing arbitrary code
dofile(path .. "test.lua")

-- Set up chat commands for changing the game time
dofile(path .. "time.lua")

-- Set up chat commands for cutting deep trenches
dofile(path .. "trench.lua")
