---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- furniture.lua
--      Set up furniture
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.furniture = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Convert suitable items to containers
local conv_file = unilib.core.path_mod .. "/lib/shared/furniture/furniture_convert.lua"

function unilib.furniture.convert_to_container(...)

    if not t[conv_file] then t[conv_file] = true; dofile(conv_file) end
    return unilib.furniture._convert_to_container(...)

end

-- "Standard" functions for unilib chairs
local sit_file = unilib.core.path_mod .. "/lib/shared/furniture/furniture_sit.lua"

function unilib.furniture.do_sit_chair(...)

    if not t[sit_file] then t[sit_file] = true; dofile(sit_file) end
    return unilib.furniture._do_sit_chair(...)

end

function unilib.furniture.can_dig_chair(...)

    if not t[sit_file] then t[sit_file] = true; dofile(sit_file) end
    return unilib.furniture._can_dig_chair(...)

end
