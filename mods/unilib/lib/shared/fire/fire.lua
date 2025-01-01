---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fire.lua
--      Set up fire
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.fire = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Get generic fire definition
local gen_file = unilib.core.path_mod .. "/lib/shared/fire/fire_generic.lua"

function unilib.fire.get_generic_definition(...)

    if not t[gen_file] then t[gen_file] = true; dofile(gen_file) end
    return unilib.fire._get_generic_definition(...)

end

-- Enable fire sound. If no Minetest setting is present, then enable the sound by default
if core.settings:get_bool("flame_sound", true) then
    dofile(unilib.core.path_mod .. "/lib/shared/fire/fire_sound.lua")
end
