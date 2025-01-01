---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- minerals.lua
--      Set up minerals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.minerals = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for minerals
local base_file = unilib.core.path_mod .. "/lib/shared/minerals/minerals_base.lua"

function unilib.register_mineral(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.minerals._register_mineral(...)

end

function unilib.register_mineral_rock(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.minerals._register_mineral_rock(...)

end

-- API functions for mineral powders
local pow_file = unilib.core.path_mod .. "/lib/shared/minerals/minerals_powder.lua"

function unilib.register_mineral_powder(...)

    if not t[pow_file] then t[pow_file] = true; dofile(pow_file) end
    return unilib.minerals._register_mineral_powder(...)

end

-- Mineral update functions
local upd_file = unilib.core.path_mod .. "/lib/shared/minerals/minerals_update.lua"

function unilib.minerals.update_mineral(...)

    if not t[upd_file] then t[upd_file] = true; dofile(upd_file) end
    return unilib.minerals._update_mineral(...)

end
