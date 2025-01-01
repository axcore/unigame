---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- panes.lua
--      Set up panes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.panes = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for panes
local base_file = unilib.core.path_mod .. "/lib/shared/panes/panes_base.lua"

function unilib.register_pane(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.panes._register_pane(...)

end
