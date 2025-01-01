---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- juice.lua
--      Set up juice
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.juice = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for juice
local base_file = unilib.core.path_mod .. "/lib/shared/juice/juice_base.lua"

function unilib.register_juice(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.juice._register_juice(...)

end

function unilib.juice.register_duplicate(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.juice._register_duplicate(...)

end
