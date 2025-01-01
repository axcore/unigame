---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- ladders.lua
--      Set up ladders
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.ladders = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for ladders
local base_file = unilib.core.path_mod .. "/lib/shared/ladders/ladders_base.lua"

function unilib.register_ladder(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.ladders._register_ladder(...)

end
