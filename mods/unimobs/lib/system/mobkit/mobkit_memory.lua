---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mobkit_memory.lua
--      Long-term memory functions for mobs
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions (from mobkit/init.lua)
-- WARNING: Mob memory is serialised. Never try to remember ObjectRefs or the tables referencing
--      them, or the engine will crash
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.add_mob_memory(self, key, val)

    -- From mobkit/init.lua, was mobkit.remember(), duplicated by kitz.remember()
    -- Permanently store a key-value pair in the specified mob's long-term "memory"

    self.memory_table[key] = val
    return val

end

function unimobs.mobkit_api.forget_mob_memory(self, key)

    -- From mobkit/init.lua, was mobkit.forget(), duplicated by kitz.forget()
    -- Clears a key-value pair from the specified mob's long-term "memory"

    self.memory_table[key] = nil

end

function unimobs.mobkit_api.recall_mob_memory(self, key)

    -- From mobkit/init.lua, was mobkit.recall(), duplicated by kitz.recall()
    -- Retrieves the value of the specified key from the specified mob's long-term "memory"

    return self.memory_table[key]

end
