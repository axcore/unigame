---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- builtin.lua
--      Apply special effects to Minetest builtin entities (adapted from various mods)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.builtin = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Apply special effects to Minetest builtin entities
dofile(unilib.core.path_mod .. "/lib/effects/builtin/builtin_falling_node.lua")
dofile(unilib.core.path_mod .. "/lib/effects/builtin/builtin_item.lua")
