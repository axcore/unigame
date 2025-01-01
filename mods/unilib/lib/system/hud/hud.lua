---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hud.lua
--      Set up the unilib HUD
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.hud = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for the unilib HUD
local base_file = unilib.core.path_mod .. "/lib/system/hud/hud_base.lua"

function unilib.hud.add_section(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.hud._add_section(...)

end

function unilib.hud.remove_section(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.hud._remove_section(...)

end

function unilib.hud.update_line(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.hud._update_line(...)

end
