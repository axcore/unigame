---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings.lua
--      Set up carvings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.carvings = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- API functions for carvings
local api_file = unilib.core.path_mod .. "/lib/shared/carvings/carvings_api.lua"

function unilib.register_carvings(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.carvings._register_carvings(...)

end

function unilib.register_carvings_all(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.carvings._register_carvings_all(...)

end
