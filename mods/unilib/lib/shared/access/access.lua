---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- access.lua
--      Set up doors, trapdoors and (fence) gates
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.access = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Register doors and trapdoors
local door_file = unilib.core.path_mod .. "/lib/shared/access/access_door.lua"

function unilib.register_door(...)

    if not t[door_file] then t[door_file] = true; dofile(door_file) end
    return unilib.access._register_door(...)

end

function unilib.register_trapdoor(...)

    if not t[door_file] then t[door_file] = true; dofile(door_file) end
    return unilib.access._register_trapdoor(...)

end

function unilib.access.get_door(...)

    if not t[door_file] then t[door_file] = true; dofile(door_file) end
    return unilib.access._get_door(...)

end

-- Register (fence) gates
local gate_file = unilib.core.path_mod .. "/lib/shared/access/access_gate.lua"

function unilib.register_gate(...)

    if not t[gate_file] then t[gate_file] = true; dofile(gate_file) end
    return unilib.access._register_gate(...)

end

-- Register store/glass traps
local trap_file = unilib.core.path_mod .. "/lib/shared/access/access_trap.lua"

function unilib.register_stone_trap(...)

    if not t[trap_file] then t[trap_file] = true; dofile(trap_file) end
    return unilib.access._register_stone_trap(...)

end

function unilib.register_glass_trap(...)

    if not t[trap_file] then t[trap_file] = true; dofile(trap_file) end
    return unilib.access._register_glass_trap(...)

end
