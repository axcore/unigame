---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- metals.lua
--      Set up metals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.metals = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for metals
local base_file = unilib.core.path_mod .. "/lib/shared/metals/metals_base.lua"

function unilib.register_metal(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.metals._register_metal(...)

end

function unilib.register_non_metal(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.metals._register_non_metal(...)

end

-- API functions for metal powders
local pow_file = unilib.core.path_mod .. "/lib/shared/metals/metals_powder.lua"

function unilib.register_metal_powder(...)

    if not t[pow_file] then t[pow_file] = true; dofile(pow_file) end
    return unilib.metals._register_metal_powder(...)

end

function unilib.register_metal_powder_from_mineral(...)

    if not t[pow_file] then t[pow_file] = true; dofile(pow_file) end
    return unilib.metals._register_metal_powder_from_mineral(...)

end

-- API functions for molten metals
local mol_file = unilib.core.path_mod .. "/lib/shared/metals/metals_molten.lua"

function unilib.register_metal_molten(...)

    if not t[mol_file] then t[mol_file] = true; dofile(mol_file) end
    return unilib.metals._register_metal_molten(...)

end

-- Metal update functions
local upd_file = unilib.core.path_mod .. "/lib/shared/metals/metals_update.lua"

function unilib.metals.update_metal(...)

    if not t[upd_file] then t[upd_file] = true; dofile(upd_file) end
    return unilib.metals._update_metal(...)

end

function unilib.metals.update_non_metal(...)

    if not t[upd_file] then t[upd_file] = true; dofile(upd_file) end
    return unilib.metals._update_non_metal(...)

end
