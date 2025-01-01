---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fishing.lua
--      Set up fishing
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.fishing = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for fishing
local base_file = unilib.core.path_mod .. "/lib/shared/fishing/fishing_base.lua"

function unilib.fishing.register_fish(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.fishing._register_fish(...)

end

function unilib.fishing.register_bonus(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.fishing._register_bonus(...)

end

function unilib.fishing.register_junk(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.fishing._register_junk(...)

end

-- Functions to select a catch
local cat_file = unilib.core.path_mod .. "/lib/shared/fishing/fishing_catch.lua"

function unilib.fishing.select_catch(...)

    if not t[cat_file] then t[cat_file] = true; dofile(cat_file) end
    return unilib.fishing._select_catch(...)

end
