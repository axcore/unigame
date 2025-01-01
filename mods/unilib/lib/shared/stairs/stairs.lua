---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs.lua
--      Set up stairs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.stairs = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- API functions for stairs
local api_file = unilib.core.path_mod .. "/lib/shared/stairs/stairs_api.lua"

function unilib.register_stairs(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.stairs._register_stairs(...)

end

function unilib.register_stairs_all(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.stairs._register_stairs_all(...)

end

-- Stair name conversion functions
local conv_file = unilib.core.path_mod .. "/lib/shared/stairs/stairs_convert.lua"

function unilib.stairs.convert_simple(...)

    if not t[conv_file] then t[conv_file] = true; dofile(conv_file) end
    return unilib.stairs._convert_simple(...)

end

function unilib.stairs.convert_inner(...)

    if not t[conv_file] then t[conv_file] = true; dofile(conv_file) end
    return unilib.stairs._convert_inner(...)

end

function unilib.stairs.convert_outer(...)

    if not t[conv_file] then t[conv_file] = true; dofile(conv_file) end
    return unilib.stairs._convert_outer(...)

end

function unilib.stairs.convert_slab(...)

    if not t[conv_file] then t[conv_file] = true; dofile(conv_file) end
    return unilib.stairs._convert_slab(...)

end

-- Stair name extraction functions
local extr_file = unilib.core.path_mod .. "/lib/shared/stairs/stairs_extract.lua"

function unilib.stairs.extract_type(...)

    if not t[extr_file] then t[extr_file] = true; dofile(extr_file) end
    return unilib.stairs._extract_stair_type(...)

end

function unilib.stairs.extract_category(...)

    if not t[extr_file] then t[extr_file] = true; dofile(extr_file) end
    return unilib.stairs._extract_category(...)

end
