---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- coral.lua
--      Set up coral
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.coral = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for coral
local base_file = unilib.core.path_mod .. "/lib/shared/coral/coral_base.lua"

function unilib.register_block_coral(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.coral._register_block_coral(...)

end

function unilib.register_rooted_coral(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.coral._register_rooted_coral(...)

end

function unilib.register_mixed_coral_as_decoration(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.coral._register_mixed_coral_as_decoration(...)

end
