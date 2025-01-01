---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fertiliser.lua
--      Set up fertiliser
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.fertiliser = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for fertilisers
local base_file = unilib.core.path_mod .. "/lib/shared/fertiliser/fertiliser_base.lua"

function unilib.fertiliser.register_special(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.fertiliser._register_special(...)

end

function unilib.fertiliser.callback_on_use(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.fertiliser._callback_on_use(...)

end
