---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dynamic.lua
--      Set up dynamic flooders and extenders for pseudo-biomes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.dynamic = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

local base_file = unilib.core.path_mod .. "/lib/shared/dynamic/dynamic_base.lua"

function unilib.dynamic.load()

    -- Original to unilib
    -- For speed, we don't use wrapper functions (as most code in ../lib/shared/ does)
    -- Instead, any packages that need dynamic items for pseudo-biomes must call this function
    if not t[base_file] then t[base_file] = true; dofile(base_file) end

end
