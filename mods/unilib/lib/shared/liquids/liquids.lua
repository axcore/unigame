---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- liquids.lua
--      Set up liquids
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.liquids = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for liquids and buckets
local base_file = unilib.core.path_mod .. "/lib/shared/liquids/liquids_base.lua"

function unilib.register_bucket(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.liquids._register_bucket(...)

end

function unilib.register_liquid(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.liquids._register_liquid(...)

end

function unilib.register_liquid_in_bucket(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.liquids._register_liquid_in_bucket(...)

end

-- Other liquid registry functions
local oth_file = unilib.core.path_mod .. "/lib/shared/liquids/liquids_other.lua"

function unilib.register_ice_snow_melting(...)

    if not t[oth_file] then t[oth_file] = true; dofile(oth_file) end
    return unilib.liquids._register_ice_snow_melting(...)

end

function unilib.register_lava(...)

    if not t[oth_file] then t[oth_file] = true; dofile(oth_file) end
    return unilib.liquids._register_lava(...)

end

-- Liquids support functions
local sup_file = unilib.core.path_mod .. "/lib/shared/liquids/liquids_support.lua"

function unilib.liquids.check_bucket_protection(...)

    if not t[sup_file] then t[sup_file] = true; dofile(sup_file) end
    return unilib.liquids._check_bucket_protection(...)

end

function unilib.liquids.get_empty_container(...)

    if not t[sup_file] then t[sup_file] = true; dofile(sup_file) end
    return unilib.liquids._get_empty_container(...)

end
