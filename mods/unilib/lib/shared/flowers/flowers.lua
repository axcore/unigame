---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flowers.lua
--      Set up flowers
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.flowers = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for flowers
local base_file = unilib.core.path_mod .. "/lib/shared/flowers/flowers_base.lua"

function unilib.register_flower(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.flowers._register_flower(...)

end

-- API functions for flowers from the beautiflowers mod
local bf_file = unilib.core.path_mod .. "/lib/shared/flowers/flowers_beautiflowers.lua"

function unilib.register_beautiflower(...)

    if not t[bf_file] then t[bf_file] = true; dofile(bf_file) end
    return unilib.flowers._register_beautiflower(...)

end
