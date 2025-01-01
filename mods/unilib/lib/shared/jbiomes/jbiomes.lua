---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- jbiomes.lua
--      Set up JIT pseudo-biomes (jbiomes)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.jbiomes = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

local base_file = unilib.core.path_mod .. "/lib/shared/jbiomes/jbiomes_base.lua"

function unilib.jbiomes.load()

    -- Original to unilib
    -- For speed, we don't use wrapper functions (as most code in ../lib/shared/ does)
    -- Instead, any packages that need JIT pseudo-biomes must call this function
    if not t[base_file] then t[base_file] = true; dofile(base_file) end

end
