---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dyes.lua
--      Set up dyes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.dyes = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for dyes
local base_file = unilib.core.path_mod .. "/lib/shared/dyes/dyes_base.lua"

function unilib.register_dye(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.dyes._register_dye(...)

end

-- Callback functions for dyed items
local cb_file = unilib.core.path_mod .. "/lib/shared/dyes/dyes_callback.lua"

function unilib.dyes.item_after_place_node(...)

    if not t[cb_file] then t[cb_file] = true; dofile(cb_file) end
    return unilib.dyes._item_after_place_node(...)

end

function unilib.dyes.item_on_punch(...)

    if not t[cb_file] then t[cb_file] = true; dofile(cb_file) end
    return unilib.dyes._item_on_punch(...)

end

function unilib.dyes.item_on_rotate(...)

    if not t[cb_file] then t[cb_file] = true; dofile(cb_file) end
    return unilib.dyes._item_on_rotate(...)

end

-- Dyed item registry functions
local reg_file = unilib.core.path_mod .. "/lib/shared/dyes/dyes_register.lua"

function unilib.dyes.register_node_with_dye(...)

    if not t[reg_file] then t[reg_file] = true; dofile(reg_file) end
    return unilib.dyes._register_node_with_dye(...)

end

function unilib.dyes.register_craft_with_dye(...)

    if not t[reg_file] then t[reg_file] = true; dofile(reg_file) end
    return unilib.dyes._register_craft_with_dye(...)

end
