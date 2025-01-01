---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- walls.lua
--      Set up walls
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.walls = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- API functions for walls
local api_file = unilib.core.path_mod .. "/lib/shared/walls/walls_api.lua"

function unilib.register_wall(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.walls._register_wall(...)

end
