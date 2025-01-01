---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- bushes.lua
--      Set up bushes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.bushes = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for bushes
local base_file = unilib.core.path_mod .. "/lib/shared/bushes/bushes_base.lua"

function unilib.register_bush_stem(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.bushes._register_stem(...)

end

function unilib.register_bush_leaves(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.bushes._register_leaves(...)

end

function unilib.register_bush_sapling(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.bushes._register_sapling(...)

end

function unilib.register_bush_sapling_lbm(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.bushes._register_sapling_lbm(...)

end

-- Grow bush saplings
local grow_file = unilib.core.path_mod .. "/lib/shared/bushes/bushes_grow.lua"

function unilib.bushes.grow_sapling(...)

    if not t[grow_file] then t[grow_file] = true; dofile(grow_file) end
    return unilib.bushes._grow_sapling(...)

end
