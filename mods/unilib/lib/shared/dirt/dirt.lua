---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dirt.lua
--      Set up dirt
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.dirt = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for dirts
local base_file = unilib.core.path_mod .. "/lib/shared/dirt/dirt_base.lua"

function unilib.register_fertile_dirt(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.dirt._register_fertile_dirt(...)

end

function unilib.register_other_dirt(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.dirt._register_other_dirt(...)

end

function unilib.register_dirt_with_turf(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.dirt._register_dirt_with_turf(...)

end

-- Dirt update functions
local upd_file = unilib.core.path_mod .. "/lib/shared/dirt/dirt_update.lua"

function unilib.dirt.update_turf_seeder_items(...)

    if not t[upd_file] then t[upd_file] = true; dofile(upd_file) end
    return unilib.dirt._update_turf_seeder_items(...)

end
